---
title: xlshim.py - Python Excel Shim - Excel Python test framework
---

```python
"""
Excel Shim - Excel Python test framework

This module provides a lightweight interface test Python code specifically written to run inside Excel
workbooks. If provides the xl() function to extract cell values or tables from Excel workbooks.

"""
import os
import openpyxl
import pandas as pd

import warnings
warnings.filterwarnings("ignore", category=UserWarning, module="openpyxl")

WEB_DESC_LINE = "Python Excel Shim - Excel Python test framework"

class ExcelShim:
    """Handles Excel workbook operations including cell and table data extraction"""
    
    def __init__(self):
        self._wb = None  # Workbook object
        self._ws = None  # Current worksheet

    def load(self, path, sheet_name=None):
        """Load an Excel workbook and set the active sheet"""
        if not os.path.exists(path):
            raise FileNotFoundError(f"Workbook not found: {path}")
        self._wb = openpyxl.load_workbook(path, data_only=True)
        self._ws = self._wb[sheet_name] if sheet_name else self._wb[self._wb.sheetnames[0]]

    def xlc(self, ref, sheet_name=None):
        """Extract a cell value by reference or named range"""
        val = None
        ws = self._wb[sheet_name] if sheet_name else self._ws

        # Handle named ranges
        if ref in self._wb.defined_names:
            defn = self._wb.defined_names[ref]
            dest = defn.destinations
            for sheet_title, cell_ref in dest:
                target_ws = self._wb[sheet_title]
                val = target_ws[cell_ref].value
                break
            else:
                raise ValueError(f"Named range '{ref}' has no valid destination.")
        else:
            # Direct cell reference (e.g., 'B2')
            val = ws[ref].value
        
        return val

    def xlt(self, table_name, sheet_name=None):
        """Extract a table as a pandas DataFrame"""
        ws = self._wb[sheet_name] if sheet_name else self._ws
        # Find the table by name
        table_obj = next((t for t in ws._tables.values() if t.name == table_name), None)
        if not table_obj:
            raise ValueError(f"Table '{table_name}' not found in sheet '{sheet_name or ws.title}'.")

        # Get table boundaries and extract data
        min_col, min_row, max_col, max_row = openpyxl.utils.range_boundaries(table_obj.ref)
        data = [
            [cell.value for cell in row]
            for row in ws.iter_rows(min_row=min_row, max_row=max_row,
                                    min_col=min_col, max_col=max_col)
        ]
        # First row as headers, remaining rows as data
        return pd.DataFrame(data[1:], columns=data[0])
    
    def xl(self, ref, sheet_name=None, type=""):
        """Generic accessor - routes to table or cell extraction based on type"""
        if type[0:1].upper() == "T":
            return self.xlt(ref, sheet_name)
        return self.xlc(ref, sheet_name)

# Global singleton instance
_shim = ExcelShim()

# Public API functions
def load(workbook_path, sheet_name=None):
    """Load an Excel workbook using the global shim instance"""
    _shim.load(workbook_path, sheet_name)

def xl(ref, headers=None, sheet_name=None, type=""):
    """Convenience function to extract cells or tables from the loaded workbook"""
    return _shim.xl(ref.replace("[#All]", ""), sheet_name, type)
```
