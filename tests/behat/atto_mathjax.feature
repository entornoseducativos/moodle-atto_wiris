@editor @editor_atto @atto @atto_wiris @_bug_phantomjs
Feature: MathML should be rendered by MathJax if the MathJax filter is first

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
  Scenario: MathML should be rendered by MathJax if the MathJax filter is first
    And I log in as "admin"
    And I navigate to "Site administration" in site administration
    And I click on "Site security settings" "link"
    And I click on "id_s__enabletrusttext" "checkbox"
    And I press "Save changes"
    And I navigate to "Plugins" in site administration
    And I follow "Manage filters"
    And I click on "On" "option" in the "MathType by WIRIS" "table_row"
    And I click on "Settings" "link" in the "MathJax" "table_row"
    And I set the following fields to these values:
      | Additional equation delimiters | <math |
    And I press "Save changes"
    And I am on "Course 1" course homepage with editing mode on
    And I add a "Forum" to section "0"
    And I set the following fields to these values:
      | Forum name | News Forum |
    And I press "Save and return to course"
    And I follow "News Forum"
    And I press "Add a new discussion topic"
    And I set the following fields to these values:
      | Subject | Test MathType for Atto on Moodle: MathJax |
    And I enable saveMode
    And I press "MathType"
    And I set MathType formula to '<math><mfrac><mn>1</mn><msqrt><mn>2</mn><mi>&#x3c0;</mi></msqrt></mfrac></math>'
    And I press accept button in MathType Editor
    And I press "Post to forum"
    And I click on "Test MathType for Atto on Moodle: MathJax" "link"
    Then element 'span' containing attribute 'class' with value 'MathJax' should exist
    And I navigate to "Plugins" in site administration
    And I follow "Manage filters"
    And I click on "Disable" "option" in the "MathJax" "table_row"
    And I am on "Course 1" course homepage
    And I follow "News Forum"
    And I follow "Test MathType for Atto on Moodle: MathJax"
    Then a Wirisformula containing 'square root' should exist
    Then Wirisformula should has height 48 with error of 2