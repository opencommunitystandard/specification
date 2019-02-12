Changes
=========

Changes from the original HSDS spec. 

For conformance reasons, I've kept the US English spellings. It might be worth evaluating whether this could cause mistakes or inconsistencies if we adopt HSDS standard.

## organization

### `description`

Changed to the following:

"The organization record is used to provide basic description and details about each organization delivering services. Each service should be linked to the organization most responsible for its delivery. One organization may deliver many services. organizations do not need to be formally established. An organization may exist as part of a larger organization."

### `tax_status`

Not a required field, but consider this out of scope of the Open Community project.

    {
        "name": "tax_status",
        "type": "string",
        "description":"Government assigned tax designation for tax-exempt organizations.",
        "constraints": {
            "required":false
        }
    }

### `year_incorporated`

Not a required field, but consider this out of scope of the Open Community project.

    {
        "name": "year_incorporated",
        "type": "date",
        "format": "%Y",
        "description":"The year in which the organization was legally formed.",
        "constraints": {
            "required":false
        }
    },

### `tax_id`

Tax ids don't have the same relevance or use in the UK. However, an incorporation code or similar may be relevant. This field is not obligatory so ignoring/removing keeps us in conformance. Instead of this field, see the proposed `register_` fields below.

    {
        "name": "tax_id",
        "type": "string",
        "description":"A government issued identifier used for the purpose of tax administration.",
        "constraints": {
            "required":false
        }
    },

### `legal_status`

Possibly out of scope for Open Community project. Also, `legal_status` will likely be captured in the proposed `register_` fields below:

    {
        "name": "legal_status",
        "type": "string",
        "description":"The legal status defines the conditions that an organization is operating under; e.g. non-profit, private corporation or a government organization.",
        "constraints": {
            "required":false
        }
    }

### `register_url`

A new field. By providing the registrar's url we can lookup the organization using the register id (see below). An example could be the charity commisison website, or companies house. This field is optional to allow for informal organizations/groups.

    {
        "name": "url",
        "type": "string",
        "format":"url",
        "description":"The URL (website address) of the body that the organization is registered with.",
        "constraints": {
            "required":false
        }
    },

### `register_id`

As described above.

    {
        "name": "register_id",
        "type": "string",
        "description":"The identifier issued to the organization by its main registring body.",
        "constraints": {
            "required":false
        }
    }
