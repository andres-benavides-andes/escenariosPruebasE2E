Feature: Tag association (Case 3)

  @user1 @web
  Scenario: Detach a tag from a post
    Given I have a version "<VERSION_APP>"
    When I log in ghost local app as an administrator with this user "<EMAIL>" and password "<PASSWORD>"
    Then I create a tag with the name  "testtag", and the description "This is a sample tast"
    Then I create a draf post with the title "My testing"
    Then I associate the tag "testtag" with the post "My testing"
    Then I detach the the last tag associated to the post "My testing"
    Then I check that tag "testtag" don't have any post related
    Then I delete the post with the title "My testing"
    Then I delete the tag with the slug "testtag"
