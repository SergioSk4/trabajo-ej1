class CursosController < ApplicationController
  before_action :set_curso, only: %i[ show edit update destroy notas cierre]

 # GET /alumnos/:id(alumno)/notas
  def notas 
    if params[:alumno] == "" || !params[:alumno] 
      @notas = @curso.notas
    else
      @notas = @curso.notas.where('alumno_id' => params[:alumno])

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
  

  # GET /cursos or /cursos.json
  def index
    @cursos = Curso.where("nombre like ?", "%#{params[:buscar]}%").page params[:page]
  end

  # GET /cursos/1 or /cursos/1.json
  def show
  end

  # GET /cursos/new
  def new
    @curso = Curso.new
  end

  # GET /cursos/1/edit
  def edit
  end

  # POST /cursos or /cursos.json
  def create
    @curso = Curso.new(curso_params)

    respond_to do |format|
      if @curso.save
        format.html { redirect_to curso_url(@curso), notice: "Curso was successfully created." }
        format.json { render :show, status: :created, location: @curso }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cursos/1 or /cursos/1.json
  def update
    respond_to do |format|
      if @curso.update(curso_params)
        format.html { redirect_to curso_url(@curso), notice: "Curso was successfully updated." }
        format.json { render :show, status: :ok, location: @curso }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cursos/1 or /cursos/1.json
  def destroy
    @curso.destroy

    respond_to do |format|
      format.html { redirect_to cursos_url, notice: "Curso was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curso
      @curso = Curso.find(params[:id])
      @alumnos = @curso.alumnos.all
    end

    # Only allow a list of trusted parameters through.
    def curso_params
      params.require(:curso).permit(:nombre, :profesor, :alumno_ids=>[])
    end
end
