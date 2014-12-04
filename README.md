# Message Resonance Ruby Sinatra Starter Application

  The IBM Watson [Message Resonance][message_resonance] analyzes draft content and scores how well it is likely to be received by a specific target audience. This analysis is based on content that has been written by the target audience itself, such as fans of a specific sports team or new parents. Today, analysis can be done against datasets from people active in cloud computing or related discussions, but future versions will let users provide their own community data.

## Getting Started

1. Create a Bluemix Account

  [Sign up][sign_up] in Bluemix, or use an existing account. Watson Services in Beta are free to use.

2. Download and install the [Cloud-foundry CLI][cloud_foundry] tool

3. Edit the `manifest.yml` file and change the `<application-name>` to something unique.
  ```none
  applications:
  - services:
    - mr-service
    name: <application-name>
    path: .
    memory: 256M
  ```
  The name you use will determinate your application url initially, e.g. `<application-name>.mybluemix.net`.

4. Connect to Bluemix in the command line tool
  ```sh
  $ cf api https://api.ng.bluemix.net
  $ cf login -u <your user ID>
  ```

5. Create the Message Resonance service in Bluemix
  ```sh
  $ cf create-service message_resonance message_resonance_free_plan mr-service
  ```

6. Push it live!
  ```sh
  $ cf push <application-name>
  ```

See the full [Getting Started][getting_started] documentation for more details, including code snippets and references.

## License

  This sample code is licensed under Apache 2.0. Full license text is available in [LICENSE](LICENSE).

## Contributing

  See [CONTRIBUTING](CONTRIBUTING.md).

## Open Source @ IBM
  Find more open source projects on the [IBM Github Page](http://ibm.github.io/)

[message_resonance]: http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/mrapi/
[cloud_foundry]: https://github.com/cloudfoundry/cli
[getting_started]: http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/getting_started/
[sign_up]: https://apps.admin.ibmcloud.com/manage/trial/bluemix.html?cm_mmc=WatsonDeveloperCloud-_-LandingSiteGetStarted-_-x-_-CreateAnAccountOnBluemixCLI