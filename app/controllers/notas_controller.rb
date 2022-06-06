class NotasController < ApplicationController
  before_action :set_nota, only: %i[ show edit update destroy cierre]


  def cierre
    if @nota.abierto?
      @nota.estado_cierre = 'Cerrado'
      @nota.save
      redirect_to @nota
    else
      redirect_to @nota, alert: "La nota ya está cerrada"
    end    
  end
  

  # GET /notas or /notas.json
  def index
    unless params[:alumno].present? || params[:curso].present?
      @notas = Nota.all.pages params[:page]
    else
      
      @notas = Nota.where("EXISTS (SELECT * FROM alumnos WHERE notas.alumno_id = alumnos.id AND nombre LIKE ?)", "%#{params[:alumno]}%").where("EXISTS (SELECT * FROM cursos WHERE notas.curso_id = cursos.id AND nombre LIKE ?)", "%#{params[:curso]}%").pages params[:page]      
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

    # Only allow a list of trusted parameters through.
    def nota_params
      params.require(:nota).permit(:curso_id, :alumno_id, :parcial1, :parcial2, :zona, :examen, :total, :bimestre, :estado_cierre)
    end
end
