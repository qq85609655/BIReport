/*
 * Copyright 2002 Sun Microsystems, Inc. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * - Redistribution in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in
 *   the documentation and/or other materials provided with the
 *   distribution.
 *
 * Neither the name of Sun Microsystems, Inc. or the names of
 * contributors may be used to endorse or promote products derived
 * from this software without specific prior written permission.
 *
 * This software is provided "AS IS," without a warranty of any
 * kind. ALL EXPRESS OR IMPLIED CONDITIONS, REPRESENTATIONS AND
 * WARRANTIES, INCLUDING ANY IMPLIED WARRANTY OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT, ARE HEREBY
 * EXCLUDED. SUN AND ITS LICENSORS SHALL NOT BE LIABLE FOR ANY DAMAGES
 * SUFFERED BY LICENSEE AS A RESULT OF USING, MODIFYING OR
 * DISTRIBUTING THE SOFTWARE OR ITS DERIVATIVES. IN NO EVENT WILL SUN
 * OR ITS LICENSORS BE LIABLE FOR ANY LOST REVENUE, PROFIT OR DATA, OR
 * FOR DIRECT, INDIRECT, SPECIAL, CONSEQUENTIAL, INCIDENTAL OR
 * PUNITIVE DAMAGES, HOWEVER CAUSED AND REGARDLESS OF THE THEORY OF
 * LIABILITY, ARISING OUT OF THE USE OF OR INABILITY TO USE SOFTWARE,
 * EVEN IF SUN HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
 *
 * You acknowledge that Software is not designed, licensed or intended
 * for use in the design, construction, operation or maintenance of
 * any nuclear facility.
 */

package waf.view.template.tags;

// J2EE Imports
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import waf.view.template.Parameter;
import waf.view.template.Screen;

// WAF imports
import waf.controller.web.util.WebKeys;

/**
 * This class is an easy interface to the JSP template or other text that needs
 * to be inserted.
 */

public class InsertTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2450725690199897685L;
	private boolean directInclude = false;
	private String parameter = null;
	private Parameter parameterRef = null;
	private Screen screen = null;

	/**
	 * default constructor
	 */
	public InsertTag() {
		super();
	}

	public void setParameter(String parameter) {
		this.parameter = parameter;
	}

	public int doStartTag() throws JspTagException {
		try {
			pageContext.getOut().flush();
		} catch (Exception e) {
			// do nothing
		}
		// load the ScreenFlow
		try {
			screen = (Screen) pageContext.getRequest().getAttribute(
					WebKeys.CURRENT_SCREEN);
		} catch (NullPointerException e) {
			throw new JspTagException("Error extracting Screen from session: "
					+ e);
		}
		if ((screen != null) && (parameter != null)) {
			parameterRef = (Parameter) screen.getParameter(parameter);
		} else {
			System.err.println("InsertTag: screenManager is null");
		}
		if (parameterRef != null)
			directInclude = parameterRef.isDirect();
		return SKIP_BODY;
	}

	public int doEndTag() throws JspTagException {
		try {
			if (directInclude && parameterRef != null) {
				pageContext.getOut().print(parameterRef.getValue());
			} else if (parameterRef != null) {
				if (parameterRef.getValue() != null
						&& !"".equals(parameterRef.getValue()))
					pageContext.include(parameterRef.getValue());
				// pageContext.getRequest().getRequestDispatcher(parameterRef.getValue()).include(pageContext.getRequest(),
				// pageContext.getResponse());
			}
		} catch (Exception ex) {
			System.err.println("InsertTag:doEndTag caught: " + ex);
			ex.printStackTrace();
		}
		return EVAL_PAGE;
	}
}