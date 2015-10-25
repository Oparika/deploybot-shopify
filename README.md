Setup with Grunt
---------------------
This theme uses Grunt for its development and support workflow. Follow the steps below when making any CSS changes.

If unsure of any step or need help, ping @cshold or @stevebosworth.

__Requirements__: [Node.js](http://nodejs.org/) (and Ruby 1.9+ on Windows).

If you don't want to use Grunt, ignore the `src/` folder and edit the files found in `assets/`.

__Do not make CSS changes in `/assets` to either `timbers.scss.liquid` or `theme.scss.liquid`. Your changes will be overwritten the next time someone uses the Grunt task.__

1. Navigate to your local Theme folder in Terminal
  - `cd path/to/folder`
  - alternatively type `cd ` then drag the folder into Terminal. It will autocomplete the path for you

2. Install Gulp globally. This step will hopefully be removed in the future.
<small>You may need to preface the command below with `sudo` to use proper permissions</small>

        $ npm install gulp -g

3. Install required packages
<small>You may need to preface the command below with `sudo` to use proper permissions</small>

        $ npm install

4. Bundle dependencies

        $ bundle install

5. Insert private app keys
  - This setup uses [Shopify's Theme Gem](https://github.com/Shopify/shopify_theme). Follow the steps in that link if you don't have it set up.
  - Add your private app keys to a file named `config.yml`. Use [this sample file](https://github.com/Shopify/Timber/blob/master/config-sample.yml) to get started. [Learn to make a private app](http://docs.shopify.com/api/authentication/creating-a-private-app).

----------

### Grunt Tasks
`$ grunt`
- Default task
- Watches `src/stylesheets/` folder and concatenates styles into `assets/timber.scss.liquid` and `/assets/theme.scss.liquid`
- Automatically compresses image files in `assets/`
- Uploads valid saved theme files to your store

----------

`$ grunt build`
- Concatenates stylesheets and compresses images
- Files are not uploaded to your store

----------

`$ grunt deploy`
- Concatenates stylesheets, compresses images, and uploads all theme files to your shop
- Note, this will overwrite all files (including active settings) so use sparingly
  - To upload all files except `settings_data.json`, add that file to your `:ignore_files` in config.yml

----------

`$ grunt zip`
- Concatenates stylesheets, compresses images, and creates a zip file with only the valid theme files
