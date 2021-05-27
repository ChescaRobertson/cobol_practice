       IDENTIFICATION DIVISION.
       PROGRAM-ID. "test_happy_birthday".
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 YOUR-NAME PIC x(10).
       PROCEDURE DIVISION.
           CALL "happy_birthday" USING "Kay" YOUR-NAME.
           CALL "assert-equals" USING YOUR-NAME "Happy Birthday Kay".
