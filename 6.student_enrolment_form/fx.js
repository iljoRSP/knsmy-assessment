const validateForm = () => {
    // validation that is already done:
    //   text fields are not empty (default JS form)
    //   email matches <a-z>@<a-z> (default JS form)
    //   except for email, text characters match ^[a-zA-Z\s]*$ (onkeydown listener)

    // remaining validation is:
    //   gender is properly selected
    //   place of birth is from the auto-fill list
    //   text (except email) contains no numbers or characters
    if (
        $('#gender').val() !== '-' && 
        Object.keys(getCountries()).includes($('#birthplace').val()) &&
        checkTextContent()
       ) {
        
        $("#output").text('Valid and "submitted".')
        
    } else $("#output").text('Invalid.')

    return false;  // don't actually submit the form
}


const checkTextContent = () => {
    let state = true;
    [$('#fname'), $('#lname'), $('#nationality')].forEach(field => {
        state &= (/^[a-zA-Z]+$/.test(field.val()))
    })

    return state;
}


const getCountries = (lang = 'en') => {
    const A = 65
    const Z = 90
    const countryName = new Intl.DisplayNames([lang], { type: 'region' });
    const countries = {}
    for(let i=A; i<=Z; ++i) {
        for(let j=A; j<=Z; ++j) {
            let code = String.fromCharCode(i) + String.fromCharCode(j)
            let name = countryName.of(code)
            if (code !== name) {
                countries[code] = name
            }
        }
    }
    return countries
}


$(document).ready(() => {
    // create country list for Place of Birth
    const target = $('#country-list')
    const list = getCountries()

    for (const key in list) {
        target.append(`<option value="${key}"> ${list[key]}</option>`)
    }
})