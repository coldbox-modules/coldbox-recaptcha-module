# ColdBox ReCAPTCHA Google v2.0 Module

This module contains helpers for using Google's ReCAPTCHA API.

reCAPTCHA is a free service that protects your site from spam and abuse. It uses advanced risk analysis techniques to tell humans and bots apart. With the 2.0 API, a significant number of your valid human users will pass the reCAPTCHA challenge without having to solve a CAPTCHA. reCAPTCHA comes in the form of a widget that you can easily add to your blog, forum, registration form, etc.

## LICENSE

Apache License, Version 2.0.

## SYSTEM REQUIREMENTS

- Lucee 5+
- ColdFusion 11+
- ColdBox 5+

## INSTRUCTIONS
Just drop into your `modules` folder or use the CommandBox to install

`box install recaptcha2`

## USAGE

### Settings

Get an API key pair at http://www.google.com/recaptcha/admin and add the following settings to your `Coldbox.cfc` under a `recaptcha` structure within the `moduleSettings` structure:

```js
moduleSettings = {
	// recaptcha settings
	recaptcha = {
    	secretKey 	= "Secret key",
    	publickey 	= "Site key",
	};
}
```

### Rendering Recaptcha

In any form you wish to add the reCaptcha widget use the following:

```html
<div class="form-group">
#renderview(
	view="widget",
	module="recaptcha",
	args={
		size = "normal" // normal or compact
	}
)#
</div>
```

The only argument the widget receives is the `size` of the captcha:
- `normal`
- `compact`

### Validation

Validation can be done manually or using or custom validator that leverages the `cbValidation` module (https://forgebox.io/view/cbValidation).

### Custom Validator

In your handler for the post of the form, or in a model object you can then use the included Validator. Here is an example of using it in a model object:

```js
this.constraints = {
	"body" 	: { required : true },
	"recaptcha" : { validator: "Validator@recaptcha" }
}
```

In the above example, your handler would just need to set the recaptcha property on the model object to the `g-recaptcha-response` value that is part of the form payload.

### Manual Validation

There also is a `RecaptchaService@recaptcha` Wirebox mapping you can use to validate manually if you prefer to not use the `cbvalidation` integration. In your handler:

```js
var recaptchaOK = getInstance( "RecaptchaService@recaptcha" ).isValid( rc[ "g-recaptcha-response" ] );

if ( !recaptchaOK ){
    writeOutput( "Prove you have a soul!" );
}
```