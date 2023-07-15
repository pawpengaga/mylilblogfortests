require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do #Los nombres de metodo son los que queramos. En español incluso
    #Revisar siempre las rutas para asegurarse que esté todo en orden
    #Revisar el panel de network del inspector del navegador
    get posts_url
    assert_response :success
    assert_equal 200, response.status #Este es el status http de que todo está okay. Estamos preguntando por codigo http 200
    assert_equal "text/html", response.media_type #Preguntamos si está trayendo correctamente el formato html
    assert_equal "utf-8", response.charset #Preguntar por si el sistema de caracteres es utf-8
    assert_equal Post.count, 4 #Preguntar por la cantidad de posts, esto está definido en fixtures

    #rails db:migrate RAILS_ENV=test
    # rails t test/controllers/posts_controller_test.rb -n test_should_get_index
  end

  test "should get show" do
    get post_url(posts(:first_post)) #Hacemos referencia al post que tenemos en las fixtures
    assert_response :success
    assert_equal 200, response.status #Este es el status http de que todo está okay. Estamos preguntando por codigo http 200
    assert_equal "text/html", response.media_type #Preguntamos si está trayendo correctamente el formato html
    assert_equal "utf-8", response.charset #Preguntar por si el sistema de caracteres es utf-8
  end

  def setup #El setup para el post de abajo. Puede usarse para más metodos luego
    @post = Post.create(title: "Otro post", description: "Este post no fue creado en las fixtures lo estamos creando ahora hehe.")
  end

  test "should get show with setup" do #Otro metodo show
    get post_url(@post) #Hace referencia al post creado en el metodo de arriba. Solo a el no a su conjunto
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "should get new" do
    get new_post_url
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "should get edit" do
    get edit_post_url(posts(:first_post)) #Precarga de formulario para cumplir con la ruta
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "should create a post" do #
    assert_difference "Post.count", 1 do
    post posts_url, params: #Este post que aparece al principio es el de http
      { post:{
        title: "Another Post",
        description: "Another Post Description"
      }}
    end
    assert_redirected_to post_url(Post.last) #Comprobación de la redirección
    assert_response :found
    assert_equal 302, response.status #302 es el codigo http apra las redirecciones
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  #Update, igual que el create
  test "should update a post" do
    patch post_url(posts(:first_post)), params: #metodo http patch
    { post:{
      title: "Updated Post",
      description: "Updated Post Description"
    }}
    posts(:first_post).reload
    assert_redirected_to post_url(posts(:first_post))
    assert_response :found
    assert_equal "Updated Post", posts(:first_post).title
    assert_equal "Updated Post Description", posts(:first_post).description
    assert_equal 302, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "should destroy a post" do
      assert_difference "Post.count", -1 do
      delete post_url(posts(:first_post))
    end
    assert_redirected_to posts_url
    assert_response :found
    assert_equal 302, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end
end
