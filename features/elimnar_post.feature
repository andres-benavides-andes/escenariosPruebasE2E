Feature: Funcion elminar post
  @user1 @web
  Scenario: Eliminar un post
    Given I have a version "<VERSION_APP>"
    Given I navigate to page "http://localhost:2368/ghost/"
    Then I enter "<EMAIL>" into input field having css selector "input[name='identification']"
    Then I enter "<PASSWORD>" into input field having css selector "input[name='password']"
    Then I click on element having css selector "button[type='submit']"
    Then I click on element having css selector "a[href='#/posts/']"
    Then I click on element having css selector ".gh-posts-list-item:nth-child(2)"
    Then I click on element having css selector ".post-settings"
    Then I wait for 3 seconds
    Then I click on element having css selector ".settings-menu-delete-button"
    Then I click on element having css selector ".gh-btn-red"
    Then I wait for 1 seconds
    Then I should see text "Posts"
