#/bin/bash
echo "Preparing devenv for OSE 2 + routing plugin + load-balancer-daemon"
echo "Installing rubygem-openshift-origin-routing-activemq"
rpm -iUvh ~/devenv-local/rubygem-openshift-origin-routing-activemq-*.noarch.rpm
echo "Configuring routing plugin"
cp /etc/openshift/plugins.d/openshift-origin-routing-activemq.conf.example /etc/openshift/plugins.d/openshift-origin-routing-activemq.conf
sed -i "s/^ACTIVEMQ_PORT='61613'$/ACTIVEMQ_PORT='6163'/" /etc/openshift/plugins.d/openshift-origin-routing-activemq.conf

echo "Adding activemq user and topic for the routing info"
sed -i 's/.*<authenticationUser username=\"admin\" password=\"secret\" groups=\"mcollective,admin,everyone\"\/>.*/&\n               <authenticationUser username=\"routinginfo\" password=\"routinginfopasswd\" groups=\"routinginfo,everyone\"\/>/' /etc/activemq/activemq.xml
sed -i 's/.*<authorizationEntry topic=\"ActiveMQ.Advisory.>\" read=\"everyone\" write=\"everyone\" admin=\"everyone\"\/>.*/&\n                  <authorizationEntry topic=\"routinginfo.>\" write=\"routinginfo\" read=\"routinginfo\" admin=\"routinginfo\" \/>\n                  <authorizationEntry queue=\"routinginfo.>\" write=\"routinginfo\" read=\"routinginfo\" admin=\"routinginfo\" \/>/' /etc/activemq/activemq.xml

echo "Adding routing plugin to broker Gemfile"
sed -i "s/.*gem 'openshift-origin-auth-streamline'.*/&\ngem 'openshift-origin-routing-activemq'/" /var/www/openshift/broker/Gemfile

echo "Getting load-balancer source code"
git clone https://github.com/dobriak/openshift-extras.git
cd ~/openshift-extras
git remote add upstream https://github.com/Miciah/openshift-extras.git
git fetch upstream
git checkout -b load-balancer -t upstream/load-balancer-initial-commit

echo "Compiling load-balancer"
cd ~/openshift-extras/admin/load-balancer
tito build --rpm --test --offline
echo "Installing load-balancer rpm"
rpm -iUvh /tmp/tito/noarch/rubygem-openshift-origin-load-balancer-daemon-*.noarch.rpm
echo "Configuring load-balancer"
sed -i -e 's/^LOAD_BALANCER=f5$/#LOAD_BALANCER=f5/' -e 's/^#LOAD_BALANCER=dummy$/LOAD_BALANCER=dummy/' -e 's/^ACTIVEMQ_HOST=broker.example.com$/ACTIVEMQ_HOST=127.0.0.1/' -e 's/^ACTIVEMQ_PORT=61613$/ACTIVEMQ_PORT=6163/' /etc/openshift/load-balancer.conf

echo "Adding load-balancer to chkconf"
chkconfig --add openshift-load-balancer-daemon
chkconfig openshift-load-balancer-daemon on

echo "Restarting activemq, rhc-broker, load-balancer"
service activemq restart
service openshift-load-balancer-daemon restart
service rhc-broker restart
echo "Done."
cd ~
