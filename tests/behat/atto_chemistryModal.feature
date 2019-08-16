@editor @editor_atto @atto @atto_wiris @_bug_phantomjs
Feature: Use atto to post a chemistry formula

  Background:
    Given the following config values are set as admin:
      | config | value | plugin |
      | toolbar | math = wiris | editor_atto |
    And the following "courses" exist:
      | fullname | shortname | format |
      | Course 1 | C1        | topics |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | admin  | C1     | editingteacher |

  @javascript
  Scenario: Use atto to post a chemistry formula
    And I log in as "admin"
    And I enable Mathtype filter
    And I am on "Course 1" course homepage with editing mode on
    And I add a "Forum" to section "0"
    And I set the following fields to these values:
      | Forum name | News Forum |
    And I press "Save and return to course"
    And I follow "News Forum"
    And I press "Add a new discussion topic"
    And I set the following fields to these values:
      | Subject | Test MathType for Atto on Moodle chemistry formulas |
    And I press "ChemType"
    And I set MathType formula to '<math><mi mathvariant="normal">H</mi><mn>2</mn><mi mathvariant="normal">O</mi></math>'
    And I press accept button in MathType Editor
    And I press "Post to forum"
    And I follow "Test MathType for Atto on Moodle chemistry formulas"
    Then ChemType formula should exist
    Then Wirisformula should has height 19 with error of 2