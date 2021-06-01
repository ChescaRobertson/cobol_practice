       IDENTIFICATION DIVISION.
       PROGRAM-ID. test-customer-filterer.
       PROCEDURE DIVISION.
           CALL "customer-filterer" USING "03-05", "2021".

          *>  SET ENVIRONMENT "cards_dat" TO "cards-birthday-0101.dat".
          *>  CALL "customer-filterer" USING "01-01", "2021".
          *>  SET ENVIRONMENT "cards_dat" TO "cards-tax-day.dat".
          *>  CALL "customer-filterer" USING "04-06", "2021".
           