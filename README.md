
# Requerimientos de ejecucion
Se debe tener corriendo localmente a ghost en la direccion http://localhost:2368/

Se debe modificar el archivo config.json con el email y la password del usuario administrador del ghost en ejecucion

El entorno local de Kraken-mobil debe configurarse acorde a la rubrica mencionada en la clase

# Funcionalidades Core
## Funcionalidad Asociar TAG
### Esenarios de prueba
  Scenario: Associate a tag to a post
    Given I log in ghost local app as an administrator with this user "<EMAIL>" and password "<PASSWORD>"
    Then I create a tag with the name  "testtag", and the description "This is a sample tast"
    Then I create a draf post with the title "My testing"
    Then I associate the tag "testtag" with the post "My testing"
    Then I validate that tag "testtag" is associate with the post "My testing"
    Then I delete the post with the title "My testing"
    Then I delete the tag with the slug "testtag"

  Scenario: Associate 3 tags to a post
    Given I log in ghost local app as an administrator with this user "<EMAIL>" and password "<PASSWORD>"
    Then I create a tag with the name  "testtag1", and the description "This is the tag 1"
    Then I create a tag with the name  "testtag2", and the description "This is the tag 2"
    Then I create a tag with the name  "testtag3", and the description "This is the tag 3"
    Then I create a draf post with the title "My testing 2"
    Then I associate the tag "testtag1" with the post "My testing 2"
    Then I associate the tag "testtag2" with the post "My testing 2"
    Then I associate the tag "testtag3" with the post "My testing 2"
    Then I validate that tag "testtag1" is associate with the post "My testing 2"
    Then I validate that tag "testtag2" is associate with the post "My testing 2"
    Then I validate that tag "testtag3" is associate with the post "My testing 2"
    Then I delete the post with the title "My testing 2"
    Then I delete the tag with the slug "testtag1"
    Then I delete the tag with the slug "testtag2"
    Then I delete the tag with the slug "testtag3"

  Scenario: Detach a tag from a post
    Given I log in ghost local app as an administrator with this user "<EMAIL>" and password "<PASSWORD>"
    Then I create a tag with the name  "testtag", and the description "This is a sample tast"
    Then I create a draf post with the title "My testing"
    Then I associate the tag "testtag" with the post "My testing"
    Then I detach the the last tag associated to the post "My testing"
    Then I check that tag "testtag" don't have any post related
    Then I delete the post with the title "My testing"
    Then I delete the tag with the slug "testtag"

  Scenario: Assosiate a tag to 2 posts
    Given I log in ghost local app as an administrator with this user "<EMAIL>" and password "<PASSWORD>"
    Then I create a tag with the name  "testtag", and the description "This is a sample tast"
    Then I create a draf post with the title "My First Post"
    Then I create a draf post with the title "My Second Post"
    Then I associate the tag "testtag" with the post "My First Post"
    Then I associate the tag "testtag" with the post "My Second Post"
    Then I validate that tag "testtag" is associate with the post "My First Post"
    Then I validate that tag "testtag" is associate with the post "My Second Post"
    Then I delete the post with the title "My First Post"
    Then I delete the post with the title "My Second Post"
    Then I delete the tag with the slug "testtag"

  Scenario: Associate a tag with a page
    Given I log in ghost local app as an administrator with this user "<EMAIL>" and password "<PASSWORD>"
    Then I create a tag with the name  "testtag", and the description "This is a sample tast"
    Then I create a draf page with the title "My new Page"
    Then I associate the tag "testtag" with the page "My new Page"
    Then I validate that tag "testtag" is associate with a page
    Then I delete the page with the title "My new Page"
    Then I delete the tag with the slug "testtag"
