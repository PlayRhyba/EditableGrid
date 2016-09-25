# EditableGrid
Thoughts about "editable grid" control. 

Test data object (raw):
```objc
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSNumber *enabled;
@property (nonatomic, strong) NSString *notes;
```
The columns' structure is set by JSON like
```js
[{
    "type": "text",
    "title": "First Name",
    "key": "firstname",
    "width": 150
  },
  {
    "type": "text",
    "title": "Last Name",
    "key": "lastname",
    "width": 150
  },
  {
    "type": "text",
    "title": "Age",
    "key": "age",
    "validator": "\\d{1,2}"
  },
  {
    "type": "text",
    "title": "Address",
    "key": "address",
    "width": 200
  },
  {
    "type": "switch",
    "title": "Active",
    "key": "enabled",
  },
  {
    "type": "text",
    "title": "Notes",
    "key": "notes",
    "width": 250
  }]
  ```
Only two types of cell are implemented: text and switch.

