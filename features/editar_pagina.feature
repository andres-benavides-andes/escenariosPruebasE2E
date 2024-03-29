Feature: Función editar una página
  @user1 @web
  Scenario: Editar una página
    Given I have a version "<VERSION_APP>"
    When I log in ghost local app as an administrator with this user "<EMAIL>" and password "<PASSWORD>"
    Then I click on element having css selector "a[href='#/pages/']"
    Then I click on element having css selector "a[href='#/editor/page/']"
    Then I enter "Crear una página con KRAKEN para luego editarla" into input field having css selector ".gh-editor-title"
    Then I enter "Cuerpo del mensaje de prueba" into input field having css selector ".koenig-editor p"
    Then I wait for 3 seconds
    Then I store a variable with the current url
    Then I click on element having css selector "a[href='#/pages/']"
    Then I should see text "Crear una página con KRAKEN para luego editarla"
    Then I wait for 3 seconds
    Then I navigate to page with the url stored in the variable
    Then I enter " - Editada" into input field having css selector ".gh-editor-title"
    Then I click on element having css selector "a[href='#/pages/']"
    Then I should see text "Crear una página con KRAKEN para luego editarla - Editada"
    Then I navigate to page with the url stored in the variable
    Then I click on element having css selector "button[title='Settings']"
    Then I click on element having css selector ".settings-menu-delete-button"
    Then I click on element having css selector ".gh-btn-red"
    Then I click on element having css selector ".gh-user-avatar"
    Then I click on element having css selector "a[href='#/signout/']"
