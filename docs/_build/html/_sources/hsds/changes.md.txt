Proposed adapations for Open Community
=========

Changes to the HSDS specification have been documented below.

To view the full specification reference, [see this page](reference.html). The original HSDS reference is also [available for comparison](http://docs.openreferral.org/en/latest/hsds/reference/).

**Language**

For conformance reasons, US English spellings have been kept. It might be worth evaluating whether this could cause mistakes or inconsistencies if we adopt the HSDS standard.

## Organisation

### Definition

The definition for an organisation record provided by Open Referral:

> _The organization record is used to provide basic description and details about each organization delivering services. Each service should be linked to the organization responsible for its delivery. One organization may deliver many services._

It will be necessary to define an organisation from the point of view of the Open Community project. This will serve as guidance to those maintaining the service directory data. Propose changing to the following:

> _The organization record is used to provide basic description and details about each organization delivering services. Each service should be linked to the organization most responsible for its delivery. One organization may deliver many services. Organizations do not need to be formally established. An organization may exist as part of a larger organization._

The Open Community project appears to be dealing with data on a much more localised scale. We want to know whether the delivery organisation is a Citizens Advice Bureau in our locality, rather than the Citizens Advice overall. I suggest we encourage "organisations" to be recorded at as granular level as possible.

### Fields

#### `tax_status`

Not a required field, but consider this out of scope of the Open Community project.

    {
        "name": "tax_status",
        "type": "string",
        "description":"Government assigned tax designation for tax-exempt organizations.",
        "constraints": {
            "required":false
        }
    }

#### `year_incorporated`

Out of scope of the Open Community project? Not required, so ignoring is still conformant.

    {
        "name": "year_incorporated",
        "type": "date",
        "format": "%Y",
        "description":"The year in which the organization was legally formed.",
        "constraints": {
            "required":false
        }
    },

#### `tax_id`

Tax ids don't have the same relevance or use in the UK. However, an incorporation code or similar may be relevant. This field is not obligatory so ignoring/removing keeps us in conformance. Instead of this field, see the proposed `register_` fields below.

    {
        "name": "tax_id",
        "type": "string",
        "description":"A government issued identifier used for the purpose of tax administration.",
        "constraints": {
            "required":false
        }
    },

#### `legal_status`

Possibly out of scope for Open Community project. Also, `legal_status` will likely be captured in the proposed `register_` fields below:

    {
        "name": "legal_status",
        "type": "string",
        "description":"The legal status defines the conditions that an organization is operating under; e.g. non-profit, private corporation or a government organization.",
        "constraints": {
            "required":false
        }
    }

#### `register`

A new field. By providing the register we can lookup the organization using the register id (see below). An example could be the Charity Commisison, or Companies House. This field is optional to allow for informal organizations/groups.

A list of commonly used registers could be provided for the user to select from to cut down number of steps in this process.

    {
        "name": "url",
        "type": "string",
        "format":"url",
        "description":"The name of the body that the organization is registered with.",
        "constraints": {
            "required":false
        }
    }

#### `register_id`

The identifier issued to the organization by its main registring body (referenced in `register_url`.

    {
        "name": "register_id",
        "type": "string",
        "description":"The identifier issued to the organization by its main registring body.",
        "constraints": {
            "required":false
        }
    }


## Program

Possibly out of scope for the Open Community project? In order to provide a good service directory is it necessary to know how an organisation groups its services? Regardless, `program` records are optional.


## Service

Like organisations, it will be necessary to define what a service is from the point of view of the Open Community project.

Is a service simply something that increases someones wellbeing? Does an app or a blog count?

### Definition

> _Services are provided by organizations to a range of different groups. Details on where each service is delivered are contained in the services_at_location table._

### Fields

#### `status`

No changes proposed. However, raises question of how Open Community should approach historical entries? Should they be stored at all?

    {
        "name": "status",
        "description": "The current status of the service (active/inactive/defunct/temporarily closed).",
        "type": "string",
        "constraints": {
            "enum": ["active", "inactive", "defunct", "temporarily closed"],
            "required":true
        }
    }


## Contact

Removed. Do not believe this is within the scope of the Open Community project.

### Definition

> _The contact table contains details of the named contacts for services and organizations. Note that in the HSDS data package format, if an individual is the contact for multiple services, their details may be duplicated multiple times in this table, each time with a new identifier, and with the rows containing different service ids._


## Phone

### Definition

> _The addresses table contains the physical addresses for locations._

### Fields

#### `contact_id`

Removed as contact object has been removed (see above).


## Physical address

### Definition

> _The addresses table contains the physical addresses for locations._

### Fields

#### `state_province`

Removed. Confusing term for viewers in the UK. Addressing in the UK can easily be achieved with 3 lines so enforcing causes unecessary work in terms of data entry.

If we need to convert to a fully HSDS conformant format, I suggest copying the contents of the `city` field into `state_province`.

```
{
    "name": "state_province",
    "description": "The state or province in which the address is located.",
    "type": "string",
    "constraints": {
        "required":true
    }
}
```


## Postal address

Possibly out of scope for a service directory? By including postal address we could be asking for a lot more data than is required.

### Definition

> _The postal_address table contains the postal addresses for mail to a certain location. This may differ from the physical location._

### Fields

#### `state_province`

Removed. Same as in `physical_address` (see above).


## Regular schedule

Possibly out of scope? Depends whether Open Community data only covers the existence of services, or whether it should detail how to access them in detail. Also worth asking whether the directory providers should task themselves with maintaing this data.

### Definition

> _The regular_schedule table contains details of when a service or location is open under normal circumstances. Each entry in the table can relate to one and only one day of the week._


## Holiday schedule

Possibly out of scope? Also worth asking whether directory providers should task themselves with maintaing this data.

### Definition

> _The holiday_schedule table contains details of when a service or location is open during holidays. Each entry in the table describes a period of one or more days, and the operating times on those days._


## Funding

Removed as this out of scope for a directory of services.

### Defintion

> _The funding table describes the sources of funding for a service or organisation._


## Eligibility

Possibly out of scope? Depends whether Open Community data only covers the existence of services, or whether it should detail how to access them in detail. Also worth asking whether the directory providers should task themselves with maintaing this data.

Also, propose flattening this into service object for simplicity.

### Defintion

> _The eligibility tables contains details of the eligibility criteria for particular services._


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
    "description": "The type of boundary.",
    "type": "string"
}
```


## Required document

Possibly out of scope for the Open Community project?

### Definition

> _The required_document table contains details of any documents that are required in order to access or use services._


## Payment acccepted

Possibly out of scope for the Open Community project?

### Definition

> _The payment_accepted table contains details of the methods of payment that can be used in order to pay for services._


## Taxonomy

HSDS provides a flexible taxonomy structure meaning we can use any set of categories we deem appropriate. Open Community could set a pre-defined list of categories, or, it could leave taxonomy out of scope, and leave it open for individual service providers to decide.

### Definition

> _Each service can be categorized according to one or more taxonomy terms. The taxonomy table contains a list of taxonomy identifiers, their names, and, for hierarchical taxonomies, their structure._
