class NotasController < ApplicationController
  before_action :set_nota, only: %i[ show edit update destroy cierre]
  before_action :set_notas, only: %i[new, cierre]


  def cierre
    if @nota.abierto?
    
      # Calcula promedio
      # Obtiene el último binestre registrado
      @maximo_bimestre = @notas.maximum('bimestre')
      @sumatoria_notas = 0
      @promedio = 0

     for i in 1..(@maximo_bimestre)
        @nota = @notas.where(:bimestre => i)
        @sumatoria_notas = @sumatoria_notas + @nota[0].total;
        @promedio = @sumatoria_notas / i;
        @nota[0].promedio = @promedio
        @nota[0].estado_cierre = 'Cerrado'
        @nota[0].save
      end
      # Guarda calores de nota
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end    
  end


  def top10
    @notas = Nota.where(:curso_id => params[:curso]).where(:bimestre => params[:bimestre]).order(promedio: :desc).limit(10)
  end


  def recuperacion
    unless params[:alumno].present? || params[:curso].present?
      @notas = Nota.where("promedio < 60")
    else
      if params[:alumno] == ""
        @notas = Nota.where(:curso_id => params[:curso]).where("promedio < 60")
      elsif params[:curso] == ""
        @notas = Nota.where(:alumno_id => params[:alumno]).where("promedio < 60")
      else
        @notas = Nota.where(:curso_id => params[:curso]).where(:alumno_id => params[:alumno]).where("promedio < 60")
      end
    end
  end


  def download
    unless params[:alumno].present? || params[:curso].present? || params[:bimestre].present?
      @notas = Nota.all
    else
      @notas = Nota.all
       params.compact_blank!

      params.each do |key, value|
        if key == "curso"
          @notas = @notas.where(:curso_id => params[:curso])
        elsif key == "alumno"
          @notas = @notas.where(:alumno_id => params[:alumno])
        elsif key == "bimestre"
          @notas = @notas.where(:bimestre => params[:bimestre])
        end
      end
    end


    # Descargar Excel
    libro = RubyXL::Workbook.new

    libro.worksheets.last.add_cell(0, 0, "Alumno")
    libro.worksheets.last.add_cell(0, 1, "Curso")
    libro.worksheets.last.add_cell(0, 2, "Nota")            
    libro.worksheets.last.add_cell(0, 3, "Bimestre")           
    libro.worksheets.last.add_cell(0, 4, "Promedio")        
    libro.worksheets.last.add_cell(0, 5, "Estado")        

    @notas.each_with_index do |nota,i|
      libro.worksheets.last.add_cell(i+1, 0, nota.alumno.nombre)
      libro.worksheets.last.add_cell(i+1, 1, nota.curso.nombre)
      libro.worksheets.last.add_cell(i+1, 2, nota.total)            
      libro.worksheets.last.add_cell(i+1, 3, nota.bimestre)            
      libro.worksheets.last.add_cell(i+1, 4, nota.promedio)    
      
      if nota.promedio < 60
        libro.worksheets.last.add_cell(i+1, 5, 'Reprobado') 
      else
        libro.worksheets.last.add_cell(i+1, 5, 'Aprobado') 

      end
    end
    

    #render json: @clientes.to_json
    send_data libro.stream.string, filename: "libro.xlsx",
                                    disposition: 'attachment'

  end
  
  
  

  # GET /notas or /notas.json
  def index
    unless params[:alumno].present? || params[:curso].present? || params[:bimestre].present?
      @notas = Nota.all.page params[:page]
    else
      @notas = Nota.all
       params.compact_blank!

      params.each do |key, value|
        if key == "curso"
          @notas = @notas.where(:curso_id => params[:curso])
        elsif key == "alumno"
          @notas = @notas.where(:alumno_id => params[:alumno])
        elsif key == "bimestre"
          @notas = @notas.where(:bimestre => params[:bimestre])
        end

      end
       @notas = @notas.page params[:page]
    end
  end

  # GET /notas/1 or /notas/1.json
  def show
  end

  # GET /notas/new
  def new
    @nota = Nota.new
    @nota.estado_cierre = 'Abierto'
  end

  # GET /notas/1/edit
  def edit
  end

  # POST /notas or /notas.json
  def create
    @nota = Nota.new(nota_params)

    @nota['total'] = nota_params['parcial1'].to_f + nota_params['parcial2'].to_f + nota_params['zona'].to_f + nota_params['examen'].to_f

    respond_to do |format|
      if @nota.save
        format.html { redirect_to nota_url(@nota), notice: "Nota was successfully created." }
        format.json { render :show, status: :created, location: @nota }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nota.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notas/1 or /notas/1.json
  def update

    @nota['total'] = nota_params['parcial1'].to_f + nota_params['parcial2'].to_f + nota_params['zona'].to_f + nota_params['examen'].to_f
    respond_to do |format|
      if @nota.update(nota_params)
        format.html { redirect_to nota_url(@nota), notice: "Nota was successfully updated." }
        format.json { render :show, status: :ok, location: @nota }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nota.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notas/1 or /notas/1.json
  def destroy
    @nota.destroy

    respond_to do |format|
      format.html { redirect_to notas_url, notice: "Nota was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nota
      @nota = Nota.find(params[:id])
    end

    def set_notas
      @notas = Nota.where(:curso_id => @nota.curso_id).where(:alumno_id => @nota.alumno_id)
    end

    # Only allow a list of trusted parameters through.
    def nota_params
      params.require(:nota).permit(:curso_id, :alumno_id, :parcial1, :parcial2, :zona, :examen, :total, :bimestre, :estado_cierre)
    end
end




class API::V1::NotasController < ApplicationController::API

end