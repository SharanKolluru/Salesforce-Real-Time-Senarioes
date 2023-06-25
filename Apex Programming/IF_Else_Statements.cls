// Simple : Multi-Line If-Else Statements
String countryCode;
String country = 'Australia';

if(country == 'India'){
    countryCode = 'IN';
}else{
    countryCode = 'OTHER';
}

// Now, In Single line If-Else Statements
countryCode = (country =='India') ? 'IN': 'OTHER';

// Complex : Multi-Line If-Else Statements
String countryCode;
String country = 'Australia';

if(country == 'India'){
    countryCode = 'IN';
}else if(country == 'Australia'){
    countryCode = 'AUS';
}else{
    countryCode = 'OTHER';
}

// Now, In Single line If-Else Statements
countryCode = (country =='India') ? 'IN': (country =='Australia')? 'AUS' : 'OTHER';
