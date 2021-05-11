Feature: Funcion editar url post
  @user1 @web
  Scenario: Editar la url de un post
    Given I navigate to page "http://localhost:2368/ghost/"
    Then I enter "<EMAIL>" into input field having css selector "input[name='identification']"
    Then I enter "<PASSWORD>" into input field having css selector "input[name='password']"
    Then I click on element having css selector "button[type='submit']"
    Then I click on element having css selector "a[href='#/posts/']"
    Then I click on element having css selector ".gh-posts-list-item:nth-child(2)"
    Then I click on element having css selector ".gh-actions-cog"
    Then I wait for 2 seconds
    Then I enter "nueva-url-kraken" into input field having css selector "input[name='post-setting-slug']" 
    Then I wait for 3 seconds
    Then I click on element having css selector ".settings-menu-header-action"
    Then I click on element having css selector ".gh-editor-back-button"
    Then I wait for 1 seconds
    Then I should see text "Posts"

