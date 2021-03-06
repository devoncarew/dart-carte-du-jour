part of carte_de_jour;

class ClientBuilderConfig {
  final String id;
  final String sdkPath;
  final GoogleComputeEngineConfig googleComputeEngineConfig;
  final List<Package> packages;

  ClientBuilderConfig._(this.id, this.sdkPath, this.googleComputeEngineConfig,
      this.packages);

  factory ClientBuilderConfig(String sdkPath,
      GoogleComputeEngineConfig googleComputeEngineConfig, List<Package> packages) {

    String _id = uuid_generator.v4().replaceAll('-','');
    _id = "b-" + _id.substring(3);
    return new ClientBuilderConfig._(_id, sdkPath, googleComputeEngineConfig,
        packages);
  }

  factory ClientBuilderConfig.fromJson(Map data) {
    String _id;
    String _sdkPath;
    GoogleComputeEngineConfig _googleComputeEngineConfig;
    List<Package> _packages;

    if (data.containsKey("id")) {
      _id = data["id"];
    }

    if (data.containsKey("sdkPath")) {
      _sdkPath = data["sdkPath"];
    }

    if (data.containsKey("googleComputeEngineConfig")) {
      _googleComputeEngineConfig = new GoogleComputeEngineConfig.fromJson(data["googleComputeEngineConfig"]);
    }

    if (data.containsKey("packages")) {
      _packages = data["packages"].map((e) => new Package.fromJson(e)).toList();
    }

    return new ClientBuilderConfig._(_id, _sdkPath, _googleComputeEngineConfig,
        _packages);
  }

  Map toJson() {
    Map map = {};
    map['id'] = id;
    map['sdkPath'] = sdkPath;
    map['googleComputeEngineConfig'] = googleComputeEngineConfig.toJson();
    map['packages'] = packages.map((e) => e.toJson()).toList();
    return map;
  }

  String toString() => JSON.encode(toJson());

  String storeFileName() => "${id}.json";

  int storeConfigSync() {
    Directory tempDir = Directory.systemTemp.createTempSync();
    File configFile = new File(join(tempDir.path, storeFileName()));
    configFile.writeAsStringSync(toString());

    List<String> args = ['-m', 'cp', configFile.path,
                         join(CLIENT_BUILDER_CONFIG_FILES_ROOT, storeFileName())];

    ProcessResult processResult = Process.runSync('gsutil', args, runInShell: true);
    Logger.root.finest(processResult.stdout);
    Logger.root.severe(processResult.stderr);
    return processResult.exitCode;
  }
}

