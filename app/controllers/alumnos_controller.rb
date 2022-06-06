class AlumnosController < ApplicationController
  before_action :set_alumno, only: %i[ show edit update destroy notas ]


  # GET /alumnos/:id(alumno)/notas
  def notas 
    if params[:curso] == "" || !params[:curso] 
      @notas = @alumno.notas
    else
      @notas = @alumno.notas.where('curso_id' => params[:curso])

      if @notas.length > 0
      
        @maximo_bimestre = @notas.maximum('bimestre')
        @sumatoria_notas = 0
  
        @notas.each do |nota|
          @sumatoria_notas = @sumatoria_notas + nota.total 
        end
  
        @sumatoria_notas = @sumatoria_notas / @maximo_bimestre
      end
      
    end
    # 
  end



  # GET /alumnos or /alumnos.json
  def index
    @alumnos = Alumno.all
  end

  # GET /alumnos/1 or /alumnos/1.json
  def show
  end

  # GET /alumnos/new
  def new
    @alumno = Alumno.new
  end

  # GET /alumnos/1/edit
  def edit
  end

  # POST /alumnos or /alumnos.json
  def create
    @alumno = Alumno.new(alumno_params)

    respond_to do |format|
      if @alumno.save
        format.html { redirect_to alumno_url(@alumno), notice: "Alumno was successfully created." }
        format.json { render :show, status: :created, location: @alumno }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alumnos/1 or /alumnos/1.json
  def update
    respond_to do |format|
      if @alumno.update(alumno_params)
        format.html { redirect_to alumno_url(@alumno), notice: "Alumno was successfully updated." }
        format.json { render :show, status: :ok, location: @alumno }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnos/1 or /alumnos/1.json
  def destroy
    @alumno.destroy

    respond_to do |format|
      format.html { redirect_to alumnos_url, notice: "Alumno was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alumno
      @alumno = Alumno.find(params[:id])
      @cursos = @alumno.cursos.all
    end

    # Calcula priomedio

    # Only allow a list of trusted parameters through.
    def alumno_params
      puts 'ERRRRRRRRROR'
      puts params
      puts 'ERRRRRRRRROR'
      params.require(:alumno).permit(:nombre, :grado, :edad, :curso_ids=>[])
    end
end
