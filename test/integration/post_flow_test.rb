#Estos son nuestros tests de integración!!!
require "test_helper"

class PostFlowTest < ActionDispatch::IntegrationTest
    def setup
        @one = posts(:first_post) #Hace referencia al modelo post, lo de dentro son los fixtures
        @two = posts(:second_post)
        @three = posts(:third_post)
    end

    test "post index" do
        #Asserts de Capybara
        visit posts_path #Simular la acción de ir la pagina principal como usuario
        assert_content page, "Posts" #Pregunta por este texto, está en el h1!!!!
        assert_content page, @one.title #Pregunta si el titulo de este post se muestra!
        assert_content page, @two.title
        assert_content page, @three.title
    end
end