Open Community
=====

This site contains documentation for OpenCommunity's version of the [Human Services Data Specification (HSDS)](http://docs.openreferral.org/en/latest/hsds/). The HSDS, and related specifications were originally developed by the [Open Referral Initiative](https://www.openreferral.org).

These standards can be used to structure and exchange information about the accessibility of health, human, and social services. Specifically, the HSDS describes data about organizations, the services they provide, the locations at which these services can be accessed, and associated details.

You can read about Open Community project including week-notes here: [https://opencommunity.org.uk/](https://opencommunity.org.uk/)

# Proposed changes

Proposed changes to the original [HSDS specification](http://docs.openreferral.org/en/latest/hsds/reference/) have been documented below.

The specification with our proposed changes is [available to view as a json file](/specification/_static/swagger-specification.json), or [as a swagger.io api specification](/specification/_static/swagger-specification.yaml). Example data formatted using our proposed changes can be [found here](/specification/example-data-1.html).


## Organization

### Definition

The definition for an organisation record provided by Open Referral:

> _The organization record is used to provide basic description and details about each organization delivering services. Each service should be linked to the organization responsible for its delivery. One organization may deliver many services._

It will be necessary to define an organisation from the point of view of the Open Community project. This will serve as guidance to those maintaining the service directory data. Propose changing to the following:

> _The organization record is used to provide basic description and details about each organization delivering services. Each service should be linked to the organization most responsible for its delivery. One organization may deliver many services. Organizations do not need to be formally established. An organization may exist as part of a larger organization._

The Open Community project appears to be dealing with data on a much more localised scale. We want to know whether the delivery organisation is a Citizens Advice Bureau in our locality, rather than the Citizens Advice overall. I suggest we encourage "organisations" to be recorded at as granular level as possible.

### Fields

#### `tax_id`

Tax ids don't have the same relevance or use in the UK. However, an incorporation code or similar may be relevant. This should be stored as a `registration` object (see below). This field is not obligatory so ignoring/removing keeps conformance with HSDS.

    {
        "name": "tax_id",
        "type": "string",
        "description":"A government issued identifier used for the purpose of tax administration.",
        "constraints": {
            "required":false
        }
    },

#### `tax_status`

Given a UK context this will likely be captured by `legal_status`. This field is not obligatory so ignoring or removing keeps conformance with HSDS.

    {
        "name": "tax_status",
        "type": "string",
        "description":"Government assigned tax designation for tax-exempt organizations.",
        "constraints": {
            "required":false
        }
    }

#### `last_updated`

New addition. Stores the last time the entry was manually updated or checked to be up to date.

    {
        "name": "last_updated",
        "type": "datetime",
        "description":"The last time the entry was manually updated or checked.",
        "constraints": {
            "required":true
        }
    }


----


## Identifier

A new object, each record provides detail of an organization's identifier as used by other databases or registers, as might be provided by regulators or industry associations. An example could be the charity number provided by the Charity Commisison.

A list of commonly used registers could be provided for the user to select from to cut down number of steps in this process.

    "properties" : {
      "id" : {
        "type" : "string",
        "description" : "Each entry must have a unique identifier."
      },
      "organization_id" : {
        "type" : "string",
        "description" : "The id of the organization for which this entry describes the registration."
      },
      "identification_body" : {
        "type" : "string",
        "description" : "The name of the body that uses or issued the identifier e.g. Companies House."
      },
      "identifier" : {
        "type" : "string",
        "description" : "The registration code or identifier issued by the body."
      }
    }


-----


## Service

Like organisations, it will be necessary to define what a service is from the point of view of the Open Community standard.

Is a service simply something that increases someones wellbeing? Does an app or a blog count?

### Fields

#### `status`

No changes proposed, however this raises considerations regarding historical entries.

    "name": "status",
    "description": "The current status of the service (active/inactive/defunct/temporarily closed).",
    "type": "string",
    "constraints": {
        "enum": ["active", "inactive", "defunct", "temporarily closed"],
        "required":true
    }

#### `location_id`

Removed in favour of using `service_at_location`. Using `service_at_location` allows us to list multiple locations, and it has a description field to better describe how services can be accessed at that location, e.g. "Meet at the front entrance".

#### `last_updated`

Stores the last time the entry was manually updated or checked to be up to date. 
        
    "last_updated" : {
      "description" : "The last time the entry was manually updated or checked.",
      "type" : "string",
      "format" : "date-time",
      "constraints" : { "required" : true }
    }


----


## Physical address

### Definition

> _The addresses table contains the physical addresses for locations._

### Fields

#### `UPRN`

"A Unique Property Reference Number (UPRN) is a unique alphanumeric identifier for every spatial address in Great Britain and can be found in OS's Address products."

    "uprn" : {
      "type" : "string",
      "description" : "Unique Property Reference Number (UPRN) used by Ordenance Survery as an identifier."
    }


----


## Regular schedule

### Definition

> _The regular_schedule table contains details of when a service or location is open under normal circumstances. Each entry in the table can relate to one and only one day of the week._

### Fields

#### `rrule` 

New addition. To provide for more detail in describing re-occurring schedules, we propose using recurrence rules from the [iCalendar (RFC 5545) specification](https://icalendar.org/iCalendar-RFC-5545/3-3-10-recurrence-rule.html).

    "rrule" : {
      "description" : "An iCalendar recurrence rule e.g. RRULE:FREQ=MONTHLY;BYDAY=+1FR",
      "type" : "string"
    }

#### `recurrence`

A human friendly version of the recurrence rule stored in `rrule`.

    "recurrence" : {
      "description" : "A human readable version of the recurrence rule",
      "type" : "string"
    }

#### `weekday`

Removed in favour of using `rrule`.


----


## Eligibility

### Definition

> _Details of eligibility criteria for particular services_

### Fields

The following fields have been added to provide for more detail in describing eligibility, `minimum_age`, `maximum_age`, and `gender`. Work to follow on determining a vocabulary or suggested options for `gender`.

    "properties": {
      "id" : {
        "type" : "string",
        "description" : "Each entry must have a unique identifier."
      },
      "service_id" : {
        "type" : "string",
        "description" : "The identifier of the service for which this entry describes the eligibility criteria."
      },
      "eligibility" : {
        "type" : "string",
        "description" : "The rules or guidelines that determine who can receive the service."
      },
      "minimum_age" : {
        "type" : "integer",
        "description" : "The minimun age required to meet this eligibility requirement."
      },
      "maximum_age" : {
        "type" : "integer",
        "description" : "The maximum age required to meet this eligibility requirement."
      },
      "gender" : {
        "type" : "string",
        "description" : "Gender restriction required to meet this eligibility requirement."
      }
    }


----


## Service area

In order to ensure compatability, it is advisable to have a pre-defined list of boundaries to select from. This is how service area selection works for the [ALISS project](https://www.aliss.org/api/v4/service-areas/).

### Defintion

> _The service_area table contains details of the geographic area for which a service is available._

### Fields

#### `identifier`

It's likely Open Community will use administrative boundary areas e.g. [local authority boundaries](https://geoportal.statistics.gov.uk/datasets/ae90afc385c04d869bc8cf8890bd1bcd_1). These have identifiers that can be used for geographic lookups and other purposes. For example `E06000009` (Blackpool).

```
{
    "name": "identifier",
    "description": "The identifier for the given boundary.",
    "type": "string"
}
```

#### `type`

The type of boundary the service area represents e.g. "Local Authority District".

```
{
    "name": "type",
    "description": "Type of boundary the service area represents eg Local Authority District",
    "type": "string"
}
```


-----


## Contact

### Fields

#### `personal_data`

Whether the record contains personal data to assist compliance with data protection and GDPR puproses.

    "personal_data" : {
      "description" : "Whether this contact includes personal data",
      "type" : "boolean"
    }

#### `sensitive_data`

A flag to identify the contact as containing sensitive information that should not be made publicly available.

    "sensitive_data" : {
      "description" : "Whether this contact is considered to be sensitive",
      "type" : "boolean"
    }