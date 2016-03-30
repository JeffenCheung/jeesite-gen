# Pactera JeeSite 企业信息化快速开发平台 V1.2.10

## 代码生成器
通过freemarker，定制模版，用以源代码生成，支持单表、主子表、树形表的生成

## 项目说明
1.	这个工程的packaging类型是war，而不是jar。
	但是最终它不会独立打出war包来，其src/main/webapp里的所有文件，
	都会被最外围的web-dist工程聚合成一个总的war 
2.	这个工程的WEB-INF目录下，没有web.xml（有也没用，最终会被覆盖）。
	默认情况下，packaging类型为war的项目，如果没有web.xml，则构建会失败，
	因此需要在pom里做一个failOnMissingWebXml配置
3.	【普通的模块】除了jeesite-common工程无额外依赖，
	直接packagingExcludes过滤所有jar
4.	【服务模块】有自主依赖jeesite-common之外的jar的模块，
	通过packagingIncludes过滤打包非共通的jar，
	注意！引入WEB-INF/classes和views等本模块的文件夹