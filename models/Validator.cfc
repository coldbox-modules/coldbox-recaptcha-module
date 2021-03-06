/**
 * Validates Google Recaptcha
 */
component accessors="true" implements="cbvalidation.models.validators.IValidator" singleton {

	/**
	 * Validator Name
	 */
	property name="name";

	/**
	 * Recaptcha Service
	 */
    property name="recaptchaService" inject="RecaptchaService@recaptcha";

	/**
	 * Constructor
	 */
    IValidator function init(){
        variables.name = "Recaptcha";
        return this;
    }

    /**
     * Will check if an incoming value validates
	 *
     * @validationResult The result object of the validation
     * @target The target object to validate on
     * @field The field on the target object to validate on
     * @targetValue The target value to validate
     * @validationData The validation data the validator was created with
     */
    boolean function validate(
		required cbvalidation.models.result.IValidationResult validationResult,
		required any target,
		required string field,
		any targetValue,
		any validationData
	){
        var result = recaptchaService.isValid( arguments.targetValue ?: "" );

        if( !result ){
            var args = {
				message        = "You must prove you are not a robot!",
				field          = arguments.field,
				validationType = getName(),
				validationData = arguments.validationData,
				rejectedValue  = arguments.targetValue
			};
            validationResult.addError( validationResult.newError( argumentCollection=args ) );
            return false;
        }

        return true;
	}

	/**
	* Get the name of the validator
	*/
	string function getName(){
		return variables.name;
	}

}