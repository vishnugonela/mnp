#eium-mysql
==========
#A Helm chart to create a single node MySQL stateful database application server on a Kubernetes cluster.

Current chart version is `0.1`

## Introduction

This chart creates a single node stateless MySQL deployment on a Kubernetes cluster using the Helm package manager.

Please refer [Kubernetes](http://kubernetes.io) and [Helm](https://helm.sh) for additional technical details on such infrastructures.

## Prerequisites

- Kubernetes 1.10+
- NFS type PV provisioner support in the underlying infrastructure, other types can be used as long as those are of  distributed type as Volume need to be available to all cluster nodes
- NFS mount layout needs to presented as per the `values.yaml` configuration, please check `persistence.volume` subPath settings
```text
    Example:
     + /var/opt/mysql
         data
         conf
         scripts
```
- Review the `values.yaml` to configure the deployment setting. Please refer the [configuration](#configuration) section for the list of parameters that can be configured during installation.              

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release eium-mysql
```

Please note that default configuration need to be tuned for production deployment. Please refer the [configuration](#configuration) section for the list of parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete --purge my-release
```
The command removes all the Kubernetes components associated with the chart and deletes the release completely.


## Chart Configuration

The following table lists the configurable parameters of the `eium-mysql` chart and their default values.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.name | string | `"eium-mysql-app"` | Application name that is used across different objects |
| container.image | string | `"localhost:5000/mysql/enterprise-server"` | Image name - fully qualified without the tag  |
| container.imageTag | string | `"8.0"` | Image tag |
| container.imagePullPolicy | string | `"IfNotPresent"` | imagePullPolicy |
| container.livenessProbe.failureThreshold | int | `10` |Minimum consecutive failures for the probe to be considered failed after having succeeded.  |
| container.livenessProbe.initialDelaySeconds | int | `1` |Delay before liveness probe is initiated |
| container.livenessProbe.periodSeconds | int | `10` | How often to perform the probe |
| container.livenessProbe.successThreshold | int | `1` |Minimum consecutive successes for the probe to be considered successful after having failed. |
| container.livenessProbe.timeoutSeconds | int | `5` | When the probe times out |
| container.name | string | `"mycontainer"` |Name of the container  |
| container.readinessProbe.failureThreshold | int | `10` |Minimum consecutive failures for the probe to be considered failed after having succeeded. |
| container.readinessProbe.initialDelaySeconds | int | `2` |Delay before readiness probe is initiated |
| container.readinessProbe.periodSeconds | int | `10` |How often to perform the probe  |
| container.readinessProbe.successThreshold | int | `1` |Minimum consecutive successes for the probe to be considered successful after having failed. |
| container.readinessProbe.timeoutSeconds | int | `1` |When the probe times out  |
| container.resources.limits.cpu | string | `"2000m"` | CPU resources for the container, this subsection is copied to the spec section of container |
| container.resources.limits.memory | string | `"4096Mi"` | Memory resources for the container, this subsection is copied to the spec section of container |
| container.resources.requests.cpu | string | `"1000m"` |CPU resources for the container, this subsection is copied to the spec section of container |
| container.resources.requests.memory | string | `"1024Mi"` |Memory resources for the container, this subsection is copied to the spec section of container |
| db.confFile | object | `{}` |Optional custom mysql configuration files used to override default mysql settings |
| db.extraEnvVars | string | `"- name: MYSQL_LOG_CONSOLE\n  value: 'true'\n- name: MYSQL_ROOT_HOST\n  value: '%'\n"` | Additional environment variables as a string to be passed to the template function |
| db.initFilesConfigMap | String | "mysql-init-files" |ConfigMap name for the data base initialization files |
| db.credentials.configureSecret | bool | `true` |Allow chart to create Secrets if enabled |
| db.credentials.passwordEncoding | string | `"plain"` |Use "base64" or "plain" if it is of base64 then no conversion to base64 happens during template execution |
| db.credentials.rootPassword | string | `"secret"` |This variable is mandatory and specifies the password that will be set for the MySQL root superuser account.|
| db.credentials.secretName | string | `"mysecret"` |Name of the Secret  |
| db.credentials.userName | string | `"siu20"` |This variables is mandatory and specifies the database user name  |
| db.credentials.userPassword | string | `"siu20"` |This variable is mandatory and specifies the database user password |
| db.startupDB | string | `"siudb"` | This variable is optional and allows you to specify the name of a database to be created on container startup  |
| persistence.accessMode | string | `"ReadWriteOnce"` |accessMode  |
| persistence.backupVolumeClaim | string | `"mysql-pvc-backup"` | PersistentVolumeClaim name for storing mysql backup files |
| persistence.enabled | bool | `true` |Create PersistentVolume if true |
| persistence.name | string | `"mymount"` |Name to be used in volume and volume mounts |
| persistence.reclaimPolicy | string | `"Retain"` | reclaimPolicy |
| persistence.storageClass | string | `"standard"` |storageClass  |
| persistence.volume.capacity | string | `"2Gi"` |Capacity of the PersistentVolume  |
| persistence.volume.confSubPath | string | `"conf/my.cnf"` |The subPath(relative location from the mount point) under which mysql conf file is stored. This should be a file name  |
| persistence.volume.create | bool | `true` |Create PersistentVolume if true  |
| persistence.volume.dataSubPath | string | `"data"` |The subPath(sub-directory) under which mysql data is stored eg. if /var/opt/mysql is your root path then it will use /var/opt/mysql/data as data dir  |
| persistence.volume.initSubPath | string | `"scripts"` |The subPath(sub-directory) under which mysql db initialization files are stored |
| persistence.volume.name | string | `"myvol"` |Name of the PersistentVolume  |
| persistence.volume.type.nfs.path | string | `"/var/opt/mysql"` |NFS Mount path  |
| persistence.volume.type.nfs.readOnly | bool | `false` | This is false always |
| persistence.volume.type.nfs.server | string | `"192.168.1.1"` |The NFS Server |
| persistence.volumeClaim.capacity | string | `"1Gi"` |PersistentVolumeClaim claim capacity  |
| persistence.volumeClaim.create | bool | `true` | Set to true if you want to create PV or PVC |
| persistence.volumeClaim.name | string | `"myclaim"` |PersistentVolumeClaim name  |
| persistence.volumeClaim.volumeSelector | string | `nil` | Persistence volume selector labels for volume claim |
| service.name | string | `"eium-dbsvc"` | Service name that need to be used by external clients for accessing database |
| service.port | int | `3306` |Service port,this should match with my.cnf configuration  |
| service.portName | string | `"mysql"` |Name of the port  |


## Persistence

The MySQL docker image stores the data and configurations at the `/var/lib/mysql` path of the container.

By default, PersistentVolume and/or PersistentVolumeClaim are created and mounted into that directory. In order to disable you can change the `persistence.volume.create` and/or `persistence.volumeClaim.create` flags. However you have to configure the right `persistence.volumeClaim.name` to store the data in an externally  created Volume. Otherwise an emptyDir volume will be used.

## Custom MySQL configuration files

The MySQL image can accepts custom configuration files at the path `/etc/my.cnf`. If you want to use a customized MySQL configuration, you can create an  alternative configuration files and place it on the persistence volume that you have configured. This is the preferred approach as the default configuration inside the image is not a production grade configuration.

Alternatively you can use `values.yaml` by configuring `confFile` attribute that in turn creates a ConfigMap

```yaml
  confFile: {}
#    my.cnf: |-
#      [mysqld]
#      port=3306
#........
```
## MySQL initialization files

The MySQL image accepts *.sql files at the path `/docker-entrypoint-initdb.d`.These files are being run exactly once for container initialization and ignored on following container restarts.
If you want to customize database initialization, you can create a set of alternative configuration files and place it on persistence volume that you have configured. This is the preferred approach to initialize the database.


## Container resources
Default configuration parameters need to be tuned to apply the right resource for the production use cases. 
Please refer [Kubernetes Compute Resources](http://kubernetes.io/docs/user-guide/compute-resources/)

```yaml
resources:
    requests:
      memory: 1024Mi
      cpu: 1000m
```
