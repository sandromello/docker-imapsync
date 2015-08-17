# Docker imapsync

From [imapsync](https://github.com/imapsync/imapsync) project.
This image consists in correcting the [oauth2](https://developers.google.com/gmail/oauth_overview)  method authentication, it's uses a fork correcting the [xoauth2 implementation](https://github.com/imapsync/imapsync/pull/25)

### XOAUTH2

For authenticating using xoauth2 follow the steps bellow:

- Create a **Google Service account** in [google console](https://console.developer.google.com)
- Create a new project
- Add a new [service account](https://developers.google.com/identity/protocols/OAuth2ServiceAccount#creatinganaccount) in credentials section (p12 type)
- Access admin.google.com
- In Security -> Advanced -> Manage Access To Client API. Grant permissions to the following app scope:
	- https://mail.google.com/ 

> In the client ID field, use the client ID received from the developer console
 
 After that it's possible to execute a new imapsync container for starting the migration, you need to pass a volume to give access to the cert received after the creation of the Google Service Account.

The command bellow could be use as example:

```bash
docker run --rm -it -v /path/to/cert.p12:/cert.p12 sandromello/imapsync --buffersize 8192000 --nosyncacls --subscribe --syncinternaldates --authuser1 --authmech1 PLAIN --authuser1 admin-imap@origin.domain.tld --host1 host1-address --user1 account@origin.domain.tld --password1 origin-pass --allowsizemismatch --authmech2 XOAUTH2 --host2 imap.gmail.com --user2 google-account@dest.domain.tld --password2 'service-account@developer.gserviceaccount.com;cert.p12' --nofoldersizes --ssl2 --dry --nolog
```

