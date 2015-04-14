using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MagicCMS.Core
{
    /// <summary>
    /// Where clause value types.
    /// </summary>
    public enum ClauseValueType
    {
        Function, Number, String, Fulltext
    }

    /// <summary>
    /// Where clause value
    /// </summary>
    public class ClauseValue
    {
        public ClauseValueType Type { get; set; }
        public object Value { get; set; }

        public ClauseValue(object value, ClauseValueType type)
        {
            Value = value;
            Type = type;
        }

        public override string ToString()
        {
            return this.Value.ToString();
        }
    }

    /// <summary>
    /// Where clause class.
    /// </summary>
    public class WhereClause
    {
        #region Fields
        private static string[] booleanOperators = new string[] { "AND", "OR", "AND NOT", "OR NOT" };
        private static string[] wOperators = new string[] { "=", "<>", ">", ">=", "<", "<=", "LIKE", "IS NULL", "IS NOT NULL", "IN", "NOT IN"};
        private string _logicalOperator;
        private string _operator;
        
        #endregion


        public string FieldName { get; set; }
        public string LogicalOperator
        {
            get { return _logicalOperator; }
            set { _logicalOperator = value.ToUpper(); }
        }

        public string Operator
        {
            get
            {
                if (!wOperators.Contains(_operator))
                {
                    return "IS NOT NULL";
                }
                return _operator;
            }
            set { _operator = value.ToUpper(); }
        }

        public ClauseValue Value
        {
            get;
            set;
        }

        public string QuotedtValue
        {
            get
            {
                if (Operator == "IS NOT NULL" || Operator == "IS NULL")
                    return "";

                switch (Value.Type)
                {
                    case ClauseValueType.Function:
                        return Value.Value.ToString();
                    case ClauseValueType.Number:
                        return Value.Value.ToString();
                    case ClauseValueType.String:
                        //return "QUOTENAME ('" + Value.ToString() + "','''')";
                        return "REPLACE ('" + Value.ToString() + "', '''', '''''')";
                    case ClauseValueType.Fulltext:
                        return "REPLACE ('%" + Value.ToString() + "%', '''', '''''')";
                        //return "QUOTENAME ('%" + Value.ToString() + "%', '''')";
                    default:
                        return "";
                }
            }
        }
    }

}