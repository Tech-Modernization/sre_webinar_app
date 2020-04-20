# Why metrics?

Having good logging and logging infrastructure in place goes a long way towards building bulletproof
applications that are easy to debug. However, logs don't tell the entire story of how an
application's behaving. Some of the most difficult problems to debug lie deep within applications
and, of course, tend to not have logs.

This is where having good metrics steps in.

# What are metrics?

A metric is an indicator of an application's behavior at a given point in time. The indicator can be
anything: an application name, the memory allocated by the application, the number of requests the
application has processed, you name it!

Metrics become immensely more useful when you start collecting a ton of them over a given time
period or _time-series_. Time series metrics enable you to calculate statistics derived from an
application's behavior, such as rates, histograms, and standard deviations.

Metrics in a time series also makes it easy to create graphs and dashboards that turn "gut feelings"
of an application's behavior into visualizations, reports and feelings backed by cold, hard data.

Most importantly, time series metrics make it possible to provide upper- and lower-bounds on how an
application is supposed to behave. These are commonly called "service level objectives" (_not_ to be
confused with "service level _agreements_"). Over time, having this data makes it possible to do
cool things like stop releases if the application blows certain service-level objectives in
production over a period of time or literally test in production safely.

You can learn more about service level objectives and the powers you can gain from having them
[here](https://landing.google.com/sre/sre-book/chapters/service-level-objectives/).

# What are good metrics?

Think about the last time that your favorite web page wasn't working.

Why wasn't it working? Did it take too long to start? Did it produce gibberish? Were pictures or
words missing where they shouldn't have been? Did you refresh the page a billion times to no avail?

It is easy to gather tons of metrics; metrics can be anything! However, most of the metrics that you
will want to see when production is on fire boil down to four things:

- **Saturation**: How many people or things are trying to use your app or service?
- **Latency**: How long did it take to use the service?
- **Errors**: How many bugs did the people or things experience when using the app?
- **Traffic**: How many people are waiting to use your app or service?

Google calls these the [four golden
signals](https://landing.google.com/sre/sre-book/chapters/monitoring-distributed-systems/).

So, what are good metrics? The answer is simple. _Anything that monitors the four golden signals are
probably good metrics._

This doesn't mean that other metrics are _bad_. Having data on those metrics can be good to have
while debugging. What we're trying to say is that not having metrics on the four golden signals
above is probably a sign that you're missing important data that will make upholding your SLOs
difficult.

# Why Prometheus and Grafana?

Our example app uses [Prometheus](https://prometheus.com) and [Grafana](https://grafana.com) for
collecting and displaying metrics, respectively.

Prometheus's approach to collecting metrics is simple: scrape metrics from an HTTP endpoint exposed
by applications, clean the data, then dump it into a time-series database. Since it relies on HTTP
for metrics collection, it does not require any agents. Moreover, the application is free to choose
how they expose those metrics (though Prometheus-compatible exporters are available for every
popular language).

Prometheus does not have clustering capabilities. If you need more Prometheus servers, you simply
spin them up.

Prometheus also does not support authentication or HTTPS. A HTTP reverse proxy is required to
enable that capability (we use NGINX for this example app).

Grafana works by collecting metrics from many systems (including Prometheus) and presenting the data
in various graphing formats. Grafana is unique in that it does not come with a query language of its
own. Instead, graphs and dashboards can be adjusted and modified based on the query engine of the
system from which the data was collected (PromQL in this example).

Both are free and open-source systems that work well in nearly any environment. Both are extremely
easy to configure through code.
