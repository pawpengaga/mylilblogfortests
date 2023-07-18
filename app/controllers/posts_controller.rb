class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy] #5. De esta forma el show y el edit saben que post están editando y usando !!! #x. Añadido update y destroy en la fase de tests

  def index
    @posts = Post.all #3.Quiero que consultes todos los posts y los guardes aqui
  end

  def show
    #6. Saben que post usar gracias a que se les ejectuta set_post
  end

  def new
    @post = Post.new #4.
  end

  #7. metodo create
  def create
    @post = Post.new(post_params) #8. Crea un post pero con los parametros del formulario


    respond_to do |format| #12. Cargador de mensajes
      if @post.save #9.
        #10. Redirigir a una vista para decir que se guardo
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        #11. Redirigir a una vista para decir que falló
        format.html { render :new, status: :unprocessable_entity } #13. Se envía a la vista new y se avisan de los errores
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  #15. Creacion del metodo update
  def update

    respond_to do |format|
      #16. El objeto fue tomado del set_post creado en edit como especificamos en el paso 5. Por lo que no es necesario un Post.new
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  #17. Creacion de metodo destroy
  def destroy
    @post.destroy #18. El objeto en memoria post es destruido con .destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." } #19. Redirige a la vista index
      format.json { head :no_content }
    end
  end

  def edit #14. El metodo edit es el del formulario
    #6. Saben que post usar gracias a que se les ejectuta set_post
  end

  def set_post
    @post = Post.find(params[:id]) #1.Busca un post que viene definido por su id y lo guarda en @post
  end

  def post_params
    params.require(:post).permit(:title, :description) #2.Del modelo post, quiero permitir solo el titulo y la descripción
  end
end
