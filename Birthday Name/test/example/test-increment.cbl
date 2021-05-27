      * A minimal example COBOL unit test
       IDENTIFICATION DIVISION.
       PROGRAM-ID. "test-increment".
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 WS-RESULT UNSIGNED-INT.
       PROCEDURE DIVISION.
      *    It increments the given number by 1
           CALL "increment" USING 1 WS-RESULT.
           CALL "assert-equals" USING WS-RESULT 2.
