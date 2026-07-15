## Updating and Publishing Your Package
### Updating the Package Version
1.  #### Update the version number: 

    Open the pubspec.yaml file and update the version number to the new version:

```yaml
version: <latest_version>
```

2. #### Update the CHANGELOG:
	Open the CHANGELOG.md file and add an entry for the new version:


```
## [latest_version] - (publish-date)

- <latest release description>

## [0.0.1] - 2024-Aug-14

- Initial developer's preview release.

```

### Testing and Publishing Your Package

1. ##### Test your package publish process:

    To test how dart pub publish will work, perform a dry run:
    
```
$ dart pub publish --dry-run    
```

This command will show you what will be published without actually uploading your package.


2. ##### Publish your package:

    Once you’re ready, publish your package to pub.dev:

```    
$ dart pub publish
``` 

Follow the prompts to complete the publication process.