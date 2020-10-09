
# download and install jars in local maven repo

snapshot_url=http://jogamp.com/deployment/v2.4.0-rc-20200307/jar
version=2.4.0rc6

maven_install_jogamp () { #groupSuffix, artifactId, version, jar classifier
    if [ -z $5 ]; then
        mvn install:install-file -DgroupId=org.jogamp.$1 -DartifactId=$2 -Dpackaging=jar -Dversion=$3 -DgeneratePom=true -Dfile=$4
    else
        mvn install:install-file -DgroupId=org.jogamp.$1 -DartifactId=$2 -Dpackaging=jar -Dversion=$3 -DgeneratePom=true -Dfile=$4 -Dclassifier=$5
    fi
}


download_install() { # groupSuffix, artifactId
  local groupSuffix=$1
  local artid=$2
  for i in '' natives-linux-amd64 natives-windows-amd64 natives-macosx-universal; do
    if [ -z $i ]; then
      jar=$artid.jar
    else
      jar=$artid-$i.jar
    fi
    wget -nc $snapshot_url/$jar
    maven_install_jogamp $groupSuffix $artid $version $jar $i
  done
}

download_install gluegen gluegen-rt

download_install jogl jogl-all

#artid=gluegen-gl
#jar=$artid.jar
#wget -nc $snapshot_url/atomic/$jar
#maven_install_jogamp gluegen $artid $version $jar ''


