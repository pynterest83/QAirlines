require('joi');
function validate(schema, source = 'body') {
    return (req, res, next) => {
        const dataToValidate = req[source];
        const { error } = schema.validate(dataToValidate, { abortEarly: false });

        if (error) {
            return res.status(400).json({ error: error.details.map((d) => d.message).join(', ') });
        }

        next();
    };
}

module.exports = validate;
