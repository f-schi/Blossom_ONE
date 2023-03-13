package routing.BlossomUtilities;

import core.DTNHost;
import org.bouncycastle.util.encoders.Hex;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class BlossomSecurity {

    public BlossomSecurity() {

    }

    /**
     * Computes a SHA-256 hash value from the given host name.
     * Adjusted code from https://www.baeldung.com/sha-256-hashing-java (Accessed: 09-07-2021)
     * @param host that get hashed.
     * @return the SHA-256 string of the host.
     */
    public final String transferHostToHashValue(DTNHost host) {
        String hostName = host.getName();
        String sha256hex= "";

        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(hostName.getBytes(StandardCharsets.UTF_8));
            sha256hex = new String(Hex.encode(hash));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return sha256hex;
    }

    /**
     * Checks if the hashed host name correspond with the given host.
     * @param hashedHost SHA-256 host name.
     * @param host host that get checked.
     * @return true when both are the same.
     */
    public final boolean isHashedHostTheGivenHost(String hashedHost, DTNHost host) {
        return hashedHost.equals(transferHostToHashValue(host));
    }
}
