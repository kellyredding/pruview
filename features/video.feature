Feature: Video
  In order to use video in more universal ways
  As a user
  I want convert video to other formats for viewing
  
  Scenario: Basic video to FLV
    Given I have a basic video file
    When I create an flv version
    Then I should have an flv file

  Scenario: Basic video to MOV
    Given I have a basic video file
    When I create an mov version
    Then I should have an mov file

  Scenario: Invalid source video
    Given I have an invalid video file
    Then Pruview should complain about an invalid source file

  Scenario: Invalid output path
    Given I have an invalid output path for videos
    Then Pruview should complain about an invalid output path

  Scenario: Invalid source format
    Given I have an invalid format file
    Then Pruview should complain about an invalid source file format
