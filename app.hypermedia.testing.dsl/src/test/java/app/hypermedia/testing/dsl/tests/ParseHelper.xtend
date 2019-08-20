package app.hypermedia.testing.dsl.tests

import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.IGrammarAccess
import org.eclipse.xtext.parser.IParser
import com.google.inject.Inject
import java.io.StringReader
import org.eclipse.xtext.GrammarUtil
import org.eclipse.xtext.ParserRule
import io.vavr.control.Either
import java.util.List
import java.util.ArrayList
import static extension org.junit.Assert.fail
import org.eclipse.emf.common.util.BasicDiagnostic
import app.hypermedia.testing.dsl.validation.CoreValidator

class ParseHelper<T extends EObject> {
    @Inject IGrammarAccess grammar;

    @Inject IParser parser;

    @Inject CoreValidator validator

    def <X extends T> Either<List<String>, X> parse(CharSequence input, Class<X> t) {
        val ruleName = t.typeName.substring(t.typeName.lastIndexOf('.') + 1, t.typeName.length())

        val parserRule = GrammarUtil
                .findRuleForName(grammar.getGrammar(), ruleName) as ParserRule;

        val px = parser.parse(parserRule, new StringReader(input.toString()))

        val errors = new ArrayList<String>
        for (error : px.syntaxErrors) {
        	errors.add(error.syntaxErrorMessage.message)
        }

        val diagnostic = new BasicDiagnostic()
        validator.validate(px.rootASTElement, diagnostic, null)

        for (error : diagnostic.children) {
            errors.add(error.message)
        }

        if (errors.size > 0) {
            return Either.left(errors)
        }

        return Either.right(px.rootASTElement as X);
    }

    def <X extends T> assertNoErrors(Either<List<String>, X> it) {
        if (isRight) {
            return get
        }

        val errors = getLeft().join(', ')

        fail('''Expected no errors but found «errors»''')
    }
}