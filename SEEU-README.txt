/* Seth Holloway - August 29, 2010
 * Adding rationale for changing routes.
 */
With our existing Sun SPOT Java code, sensors and actuators both use HTTP GET. This breaks with the otherwise RESTful architecture; to accommodate the change, I edited the routes to accept posting with GET rather than editing the SPOT code, which I believe is less stable.

To change the SPOT code, edit SVN/seap/trunk/test/src/edu/utexas/ece/mpc/spot/UriToResponseBodyTransformer.java to include a setRequestMethod("POST")

Documentation here: http://download.oracle.com/javase/1.4.2/docs/api/java/net/HttpURLConnection.html#setRequestMethod(java.lang.String)

