# Launch Nailgun server (customised for GOAL) at dyno start up
# ------------------------------------------------------------

# All scripts in this directory are sourced at dyno start up. The order is
# arbitrary.

# These paths have to coincide with the paths and files created by the
# GOAL and Nailgun buildpacks. We cannot use, for example, $(which goal),
# because the order of execution of the .profile.d scripts is arbitrary,
# and thus the paths for GOAL and Nailgun may not have been set yet.
GOAL_DIR=$HOME/vendor/goal          # The installation location of GOAL
GOAL_JAR=$GOAL_DIR/lib/jpf-boot.jar # The main JAR for launching GOAL
NAILGUN_DIR=$HOME/vendor/nailgun    # Installation location of Nailgun
NAILGUN_SERVER=$NAILGUN_DIR/nailgun-server-0.9.2-SNAPSHOT.jar # Nailgun server

# Start a JVM, customised for the execution of GOAL (as in $GOAL_DIR/goal),
# running the Nailgun server (class com.martiansoftware.nailgun.NGServer).
java \
-DapplicationRoot="$GOAL_DIR" \
-Dorg.java.plugin.boot.pluginsRepositories="$GOAL_DIR/plugins" \
-Djpf.boot.config="$GOAL_DIR/boot.properties" \
-Dorg.apache.commons.logging.Log=org.apache.commons.logging.impl.SimpleLog \
-Dorg.apache.commons.logging.simplelog.log.org.java.plugin=fatal \
-classpath $NAILGUN_SERVER:$GOAL_JAR \
com.martiansoftware.nailgun.NGServer >/dev/null &


# Now, GOAL can be executed with ng org.java.plugin.boot.Boot <goal_args>.
# We replace the old GOAL launching script with a new one. The old one starts
# up a JVM executing GOAL, the new one orders the Nailgun server to execute
# GOAL.
mv $GOAL_DIR/goal $GOAL_DIR/goal.old
echo '#!/bin/bash' > $GOAL_DIR/goal
echo 'ng org.java.plugin.boot.Boot "$@"' >> $GOAL_DIR/goal
chmod +x $GOAL_DIR/goal

# This works because org.java.plugin.boot.Boot is the main class of the JAR
# file $GOAL_JAR, which is the JAR file to launch GOAL. Since we put $GOAL_JAR
# in the classpath for the Nailgun server, the Nailgun server knows how to
# find this class.