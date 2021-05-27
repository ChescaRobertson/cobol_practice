      * main-program.cbl 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. main-program.
       DATA DIVISION.
      * This is a new type of division! The Data Division.
      * We use it to declare variables.
      * It's broken up into sections. 
           WORKING-STORAGE SECTION.
      *    The Working Storage section is for your everyday variables.
      *    It contains one or more variable declarations.     
           01 WS-SUM UNSIGNED-INT.
      *    01           is a 'level number'. Ignore it for now.
      *    WS-SUM       is the name of the variable
      *    UNSIGNED-INT is the type of the variable.     
       PROCEDURE DIVISION.
           CALL "square" USING 3 WS-SUM.
      *    USING is new.
      *    It's a way of saying 'give these values and variables
      *    to the subprogram.     
           DISPLAY WS-SUM.
      *    And now we display the output.
      *    When we give the subprogram WS-SUM, it can just change it directly.
      *    There is no need for us to assign the return value explicitly.     
           