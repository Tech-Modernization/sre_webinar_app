# Contino's SRE Webinar App

This is the app that we used for the SRE webinar. Start it by running
`./start_app.sh`.

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

# Cool! How do I run it?

Start the web app with `start_app.sh`. Prom and Grafana will start up with it.

Prometheus will be on https://localhost:8080.

Grafana will be on https://localhost:8081.

(These are using self-signed certificates, so expect browser validation errors.)

# Monitoring as Code

Prometheus and Grafana make it easy to store your monitoring configurations in code. Check out
some examples of this in the `monitoring/{prometheus,grafana}` folders.
