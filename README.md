# Contino's SRE Webinar App

This is the app that we used for the SRE webinar. Start it by running
`SPLUNK_PASSWORD=<your_password_here> ./start_app.sh`.

You can access the app by navigating your web browser to http://localhost.

# Monitoring SLIs with Prometheus and Grafana

Once you have SLOs identified for your app, you're going to want to track their SLIs with a
monitoring tool. I love using Prometheus and Grafana for this for a few reasons:

- It's dead easy to install, both in dev and in production.
- They are very UNIX-y, in that they each do one thing, and they do it well
  (Prom does monitoring really well; Graf does dashboarding really well)
- You can write all of your monitoring and dashboards with code, which many
  products either don't support, or they make this way more complicated than
  it needs to be.

# Logging with Splunk

Splunk makes it easy to collect logs from pretty much anywhere fast and reliably. It plays nicely
with many popular logging libraries and can ingest logs from files, `stdout`, other logging systems,
over-the-wire and more!

Our example app contains a Dockerized version of Splunk Enterprise. No configuration is needed on
your part.

# Cool! How do I run it?

Start the web app with `SPLUNK_PASSWORD=<your_password_here> ./start_app.sh`.
Prom, Grafana, Splunk and Jaeger will start up with it.

The app will be on http://localhost:5000.

Prometheus will be on https://localhost:8080.

Grafana will be on https://localhost:8081. Username and password are 'grafana'.

Jaeger will be on http://localhost:8082.

Splunk will be on http://localhost:8000. Username is 'admin'.

(These are using self-signed certificates, so expect browser validation errors.)

# Monitoring as Code

Prometheus and Grafana make it easy to store your monitoring configurations in code. Check out
some examples of this in the `monitoring/{prometheus,grafana}` folders.

You can also see configuration for Jaeger and Splunk by visiting `monitoring/{jaeger,splunk}`.
