import java.io.File;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.filefilter.RegexFileFilter;
import org.apache.commons.io.filefilter.TrueFileFilter;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.xtext.generator.GeneratorContext;
import org.eclipse.xtext.generator.GeneratorDelegate;
import org.eclipse.xtext.generator.JavaIoFileSystemAccess;
import org.eclipse.xtext.util.CancelIndicator;
import org.eclipse.xtext.validation.CheckMode;
import org.eclipse.xtext.validation.IResourceValidator;
import org.eclipse.xtext.validation.Issue;

import com.google.inject.Inject;
import com.google.inject.Injector;
import com.google.inject.Provider;

import app.hypermedia.testing.dsl.CoreStandaloneSetup;
import app.hypermedia.testing.dsl.HydraStandaloneSetup;

public class GeneratorMain {
    
    private static Map<String, GeneratorRunner> runners = new HashMap<String, GeneratorRunner>();
    
    public static void main(String[] args) {
        Injector coreInjector = new CoreStandaloneSetup().createInjectorAndDoEMFRegistration();
        Injector hydraInjector = new HydraStandaloneSetup().createInjectorAndDoEMFRegistration();
        
        runners.put("api", coreInjector.getInstance(GeneratorRunner.class));
        runners.put("hydra", hydraInjector.getInstance(GeneratorRunner.class));
        
        generateDirectory(args[0]);
        System.out.println("Done!");
    }

    private static void generateDirectory(String directoryName) {
        File dir = new File(directoryName);
        Collection<File> files = FileUtils.listFiles(dir, new RegexFileFilter(".+\\.(api|hydra)$"), TrueFileFilter.INSTANCE);

        for (File file : files) {
            if (file.isDirectory()) {
                generateDirectory(file.getPath());
                continue;
            }
            
            String ext = FilenameUtils.getExtension(file.getPath());
            
            GeneratorRunner runner = runners.get(ext);
            
            if (runner != null) {
                runner.generate(file);
            }
        }
    }
}



class GeneratorRunner {
    @Inject
    Provider<ResourceSet> resourceSetProvider;

    @Inject
    IResourceValidator validator;

    @Inject
    GeneratorDelegate generator;

    @Inject
    JavaIoFileSystemAccess fileAccess;
    
    public void generate(File input) {
        System.out.printf("Compiling %s %n", input.getPath());

        ResourceSet resourceSet = resourceSetProvider.get();
        Resource resource = resourceSet.getResource(URI.createFileURI(input.getPath()), true);

        if (!this.validate(resource)) {
            return;
        }

        fileAccess.setOutputPath(input.getParentFile().getPath());
        generator.generate(resource, fileAccess, new GeneratorContext());
    }

    private boolean validate(Resource resource) {
        List<Issue> issues = validator.validate(resource, CheckMode.ALL, CancelIndicator.NullImpl);
        if (!issues.isEmpty()) {
            issues.forEach(issue -> System.out.printf(
                    "Line %3s: %s %s %n",
                    issue.getLineNumber(),
                    issue.getSeverity(),
                    issue.getMessage()));
            return false;
        }

        return true;
    }
}
