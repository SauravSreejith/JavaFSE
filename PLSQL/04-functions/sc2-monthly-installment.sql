SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(
    p_loan_amount   IN NUMBER,
    p_annual_rate   IN NUMBER,    p_duration_years IN NUMBER
) RETURN NUMBER IS
    v_monthly_rate NUMBER;
    v_num_payments NUMBER;
    v_installment  NUMBER;
BEGIN
    IF p_loan_amount IS NULL OR p_loan_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20030, 'Loan amount must be greater than zero.');
    END IF;

    IF p_duration_years IS NULL OR p_duration_years <= 0 THEN
        RAISE_APPLICATION_ERROR(-20031, 'Loan duration must be greater than zero years.');
    END IF;

    v_num_payments := p_duration_years * 12;

    IF p_annual_rate IS NULL OR p_annual_rate = 0 THEN
        v_installment := p_loan_amount / v_num_payments;
    ELSE
        v_monthly_rate := p_annual_rate / 100 / 12;

        v_installment := p_loan_amount *
                         (v_monthly_rate * POWER(1 + v_monthly_rate, v_num_payments)) /
                         (POWER(1 + v_monthly_rate, v_num_payments) - 1);
    END IF;

    RETURN ROUND(v_installment, 2);
END CalculateMonthlyInstallment;
/

PROMPT === Testing CalculateMonthlyInstallment ===

DECLARE
    v_installment NUMBER;
BEGIN
    v_installment := CalculateMonthlyInstallment(5000, 5, 5);
    DBMS_OUTPUT.PUT_LINE('Loan: $5000 | Rate: 5% | 5 years => Monthly: $' || v_installment);

    v_installment := CalculateMonthlyInstallment(12000, 6, 2);
    DBMS_OUTPUT.PUT_LINE('Loan: $12000 | Rate: 6% | 2 years => Monthly: $' || v_installment);

    v_installment := CalculateMonthlyInstallment(6000, 0, 3);
    DBMS_OUTPUT.PUT_LINE('Loan: $6000 | Rate: 0% | 3 years => Monthly: $' || v_installment);
END;
/

SELECT
    LoanID,
    LoanAmount,
    InterestRate,
    CalculateMonthlyInstallment(LoanAmount, InterestRate, 5) AS MonthlyInstallment_5yr
FROM Loans;
