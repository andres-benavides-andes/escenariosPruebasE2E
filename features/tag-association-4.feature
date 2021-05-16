Feature: Tag association (Case 4)

  @user1 @web
  Scenario: Assosiate a tag to 2 posts
    Given I have a version "3.3.0"
    When I log in ghost local app as an administrator with this user "<EMAIL>" and password "<PASSWORD>"
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
