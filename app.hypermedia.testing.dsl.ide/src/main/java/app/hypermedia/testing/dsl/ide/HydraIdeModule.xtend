/*
 * generated by Xtext 2.18.0
 */
package app.hypermedia.testing.dsl.ide

import org.eclipse.xtext.ide.editor.contentassist.IdeContentProposalProvider
import app.hypermedia.testing.dsl.ide.editor.contentassist.HydraContentAssist

/**
 * Use this class to register ide components.
 */
class HydraIdeModule extends AbstractHydraIdeModule {
    def Class<? extends IdeContentProposalProvider> bindIdeContentProposalProvider() {
        return HydraContentAssist
    }
}
