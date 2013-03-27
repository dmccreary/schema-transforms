xquery version "1.0";

declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare namespace xf="http://www.w3.org/2002/xforms";

let $doc-path := '/db/apps/grants/schemas/GrantsFundingSynopsis-V2.0.xsd'

return
if (not(doc-available($doc-path)))
  then <error>Doc {$doc-path} is not available</error> else

let $lists := doc($doc-path)/xs:schema//xs:restriction[xs:enumeration]

return
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:xf="http://www.w3.org/2002/xforms">
    <head>
        <title>Address Form</title>
    </head>
   <lists>{count($lists)}</lists>
    {for $list in $lists
      let $name := $list/../../@name/string()
      return
      <xf:select1 ref="{$name}">
          <xf:label>{$name}</xf:label>
          {for $value in $list/xs:enumeration/@value
           return
           <xf:item>
              <xf:label>
              {
                 for $doc in $value/../../../xs:annotation/xs:documentation/text()
                 return
                    if ( starts-with($doc, $value) )
                       then substring-after($doc, '- ')
                       else ()
                       }
              </xf:label>
              <xf:value>{$value/string()}</xf:value>
           </xf:item>
           }
      </xf:select1>
     }
</html>