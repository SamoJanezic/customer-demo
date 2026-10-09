CodeImporter evaluateFileNamed: '/app/backend/Person.st'.
CodeImporter evaluateFileNamed: '/app/backend/PersonsRepository.st'.
CodeImporter evaluateFileNamed: '/app/backend/PersonsApi.st'.

Smalltalk globals at: #PersonsApiInstance put: (Smalltalk globals at: #PersonsApi) new.
(Smalltalk globals at: #PersonsApiInstance) start.

Transcript show: 'Persons API listening on port 8081'; cr.
