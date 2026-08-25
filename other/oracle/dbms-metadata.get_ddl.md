---
title: Oracle
---
# DBMS_METADATA.get_ddl Defaults

```
-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: BODY
-- Objects: PACKAGE: If TRUE, output the package body.
-- Objects: TYPE: If TRUE, output the type body.
-- Default: TRUE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'BODY', TRUE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: CONSTRAINTS
-- Objects: TABLE: If TRUE, output all non-referential table constraints.
-- Default: TRUE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'CONSTRAINTS', TRUE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: CONSTRAINTS_AS_ALTER
-- Objects: TABLE: If TRUE, output table constraints as separate ALTER TABLE (and, if necessary, CREATE INDEX)
--          statements. If FALSE, specify table constraints as part of the CREATE TABLE statement.
--          Requires that CONSTRAINTS be TRUE.
-- Default: FALSE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'CONSTRAINTS_AS_ALTER', FALSE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: DEFAULT
-- Objects: All objects: Calling SET_TRANSFORM_PARAM with this parameter set to TRUE has the effect of
--          resetting all parameters for the transform to their default values. Setting this FALSE has no effect.
-- There is no default.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'DEFAULT', FALSE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: FORCE
-- Objects: VIEW: If TRUE, use the FORCE keyword in the CREATE VIEW statement.
-- Default: TRUE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'FORCE', TRUE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: INHERIT
-- Objects: All objects: If TRUE, inherits session-level parameters. If an application calls ADD_TRANSFORM to
--          add the DDL transform, then by default the only transform parameters that apply are those explicitly
--          set for that transform handle. This has no effect if the transform handle is the session transform
--          handle.
-- Default: FALSE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'INHERIT', FALSE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: OID
-- Objects: TABLE: If TRUE, output the OID clause for object tables.
-- Objects: TYPE: If TRUE, output the OID clause.
-- Default: FALSE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'OID', FALSE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: PARTITIONING
-- Objects: TABLE, INDEX: If TRUE, output partitioning clauses; if FALSE, suppress them.
-- Default: TRUE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'PARTITIONING', TRUE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: PCTSPACE
-- Objects: CLUSTER, INDEX, ROLLBACK_SEGMENT, TABLE, TABLESPACE: A number representing the percentage by
--          which space allocation for the object type is to be modified. The value is the number of
--          one-hundreths of the current allocation. For example, 100 means 100%.  If the object type is
--          TABLESPACE, the following size values are affected: - in file specifications, the value of SIZE,
--          MINIMUM EXTENT, EXTENT MANAGEMENT LOCAL UNIFORM SIZE For other object types, INITIAL and NEXT are
--          affected.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'PCTSPACE', NUMBER);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: PRETTY
-- Objects: All objects: If TRUE, format the output with indentation and line feeds.
-- Default: TRUE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'PRETTY', TRUE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: REF_CONSTRAINTS
-- Objects: TABLE: If TRUE, output all referential constraints (foreign keys).
-- Default: TRUE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'REF_CONSTRAINTS', TRUE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: REUSE
-- Objects: TABLESPACE: If TRUE, include the REUSE parameter for datafiles in a tablespace to indicate that
--          existing files can be reused.
-- Default: FALSE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'REUSE', FALSE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: REVOKE_FROM
-- Objects: ROLE: The name of a user from whom the role must be revoked. If this is a non-null string and if
--          the CREATE ROLE statement grants you the role, a REVOKE statement is output after the CREATE ROLE.
--          Note: When you issue a CREATE ROLE statement, Oracle may grant you the role. You can use this
--          transform parameter to undo the grant.
-- Default: null string.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'REVOKE_FROM', Text);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: SEGMENT_ATTRIBUTES
-- Objects: INDEX, CONSTRAINT, ROLLBACK_SEGMENT, CLUSTER, TABLESPACE: If TRUE, output segment attributes
--          (physical attributes, storage attributes, tablespace, logging).
-- Objects: TABLE: If TRUE, output segment attributes (physical attributes, storage attributes, tablespace,
--          logging).
-- Default: TRUE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SEGMENT_ATTRIBUTES', TRUE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: SIZE_BYTE_KEYWORD
-- Objects: TABLE: If TRUE, output the BYTE keyword as part of the size specification of CHAR and VARCHAR2
--          columns that use byte semantics. If FALSE, omit the keyword.
-- Default: FALSE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SIZE_BYTE_KEYWORD', FALSE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: SPECIFICATION
-- Objects: PACKAGE: If TRUE, output the package specification.
-- Objects: TYPE: If TRUE, output the type specification.
-- Default: TRUE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SPECIFICATION', TRUE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: SQLTERMINATOR
-- Objects: All objects: If TRUE, append a SQL terminator (; or /) to each DDL statement.
-- Default: FALSE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SQLTERMINATOR', FALSE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: STORAGE
-- Objects: INDEX, CONSTRAINT, ROLLBACK_SEGMENT, CLUSTER: If TRUE, output storage clause. (Ignored if
--          SEGMENT_ATTRIBUTES is FALSE.)
-- Objects: TABLE: If TRUE, output storage clause. (Ignored if SEGMENT_ATTRIBUTES is FALSE.)
-- Default: TRUE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'STORAGE', TRUE);

-- --------------------------------------------------------------------------------------------------------------
-- Paramtr: TABLESPACE
-- Objects: INDEX, CONSTRAINT, ROLLBACK_SEGMENT, CLUSTER: If TRUE, output tablespace. (Ignored if
--          SEGMENT_ATTRIBUTES is FALSE.)
-- Objects: TABLE: If TRUE, output tablespace. (Ignored if SEGMENT_ATTRIBUTES is FALSE.)
-- Default: TRUE.
-- --------------------------------------------------------------------------------------------------------------
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'TABLESPACE', TRUE);
```
<hr>
