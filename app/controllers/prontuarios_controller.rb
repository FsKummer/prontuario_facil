class ProntuariosController < PagesController
  before_action :ensure_user_logged_in, only: %i[index new create]

  def index
    set_user_prontuaries
    respond_to do |format|
      if turbo_content_request?
        format.html { render partial: "prontuarios/partials/prontuarios" }
      else
        format.html { render USER_HOME_PARTIAL }
      end
    end
  end

  def new
    @prontuario = Prontuario.new
    render partial: "prontuarios/partials/create_prontuario"
  end

  def create
    @prontuario = current_user.prontuarios.build(prontuario_params)

    if @prontuario.save
      set_user_prontuaries
      flash.now[:notice] = "Prontuário criado com sucesso."
      render partial: "prontuarios/partials/prontuarios"
    else
      render partial: "prontuarios/partials/create_prontuario", status: :unprocessable_entity
    end
  end

  private

  def prontuario_params
    params.require(:prontuario).permit(:nome)
  end
end
