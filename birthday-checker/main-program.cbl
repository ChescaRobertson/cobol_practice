       IDENTIFICATION DIVISION.
       PROGRAM-ID. main-program.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 WS-NAME PIC A(10).
           01 WS-BIRTHDAY UNSIGNED-INT.
           01 WS-TODAY UNSIGNED-INT.
           01 WS-BIRTHDAY-GREETER PIC A(40).
       PROCEDURE DIVISION.
           MOVE FUNCTION CURRENT-DATE(5:4) TO WS-TODAY
      
           DISPLAY "What is your name?".
           ACCEPT WS-NAME.
           DISPLAY "What is your birthday (MMDD)?".
           ACCEPT WS-BIRTHDAY.
           CALL "birthday-checker" USING WS-NAME, WS-BIRTHDAY, WS-TODAY,
           WS-BIRTHDAY-GREETER.


           
         

