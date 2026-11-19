package org.sasanlabs.service;

import java.util.logging.Logger;

public class PaymentLogger {
    private static final Logger LOGGER = Logger.getLogger(PaymentLogger.class.getName());

    public void logTransfer(String iban, long amountCents) {
        LOGGER.info("Transfer of " + amountCents + " cents from IBAN " + iban);
    }

    public long toCents(String amount) {
        return Math.round(Double.parseDouble(amount) * 100);
    }

    public long amountInCents(String amount) {
        return Math.round(Double.parseDouble(amount) * 100);
    }
}
